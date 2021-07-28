//
//  listViewFunctions.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI
import CoreData

protocol ListProtocol {
    func getList(_ a: [ListItem], _ search: String) -> [ListItem]
}

struct ListStruct : ListProtocol {
    func getList(_ a: [ListItem], _ search: String) -> [ListItem] {
        a.filter( {"\($0.emoji)\($0.name)".lowercased().contains(search.lowercased()) || search.isEmpty} )
    }

    func canEdit(detailListItems: FetchedResults<ListItem>,_ catItem: ListItem) -> EditButton? {
        coldFilter(detailListItems, catItem).isEmpty ? nil : EditButton()
    }

    func coldFilter(_ a: FetchedResults<ListItem>,_ catItem: ListItem) -> [ListItem] {
        if catItem.uuidString == "Stars" {
            return a.filter( { $0.isParent == false && $0.star == true  })
        } else if catItem.uuidString == "Everything" {
            return a.filter( { $0.isParent == false  })
        } else {
            return a.filter( { $0.uuidString == catItem.uuidString &&  $0.isParent == false  })
        }
    }

    func reindex(catItem: ListItem, detailListItems: FetchedResults<ListItem>) {
        // reorder items
        coldFilter(detailListItems,catItem).enumerated().forEach { index, item in
            if item.order != index {
                item.order = index
            }
        }
    }

    func saveItems(_ managedObjectContext: NSManagedObjectContext) {
        // When saving a Context, always use the main thread to avoid collisions
        DispatchQueue.main.async() {
            if managedObjectContext.hasChanges {
                try? managedObjectContext.save()
            }
        }
    }

    func moveThisItem(_ source: IndexSet,
                      _ destination: Int,
                      _ detailListItems: FetchedResults<ListItem>,
                      _ managedObjectContext: NSManagedObjectContext,
                      _ catItem: ListItem,
                      _ searchText: String) {
        let list = ListStruct()
        var item = coldFilter(detailListItems,catItem)
        item = list.getList(item, searchText)
        item.move(fromOffsets: source, toOffset: destination)

        for i in 0..<item.count {
            item[i].order = i

            for j in 0..<detailListItems.count {
                if item[i].objectID == detailListItems[j].objectID {
                    detailListItems[j].order = item[i].order
                    break
                }
            }
        }
        saveItems(managedObjectContext)
    }

    func deleteThisItem(_ indexSet: IndexSet,
                   _ detailListItems: FetchedResults<ListItem>,
                   _ catItem: ListItem,
                   _ managedObjectContext: NSManagedObjectContext,
                   _ security: Security,
                   _ searchText: String
                   ) {
        let list = ListStruct()

        var indexIsValid = false
        var cf = coldFilter(detailListItems, catItem)
        cf = list.getList(cf, searchText)

        if let source = indexSet.first {
            indexIsValid = cf.indices.contains(source)
        }

        if !indexIsValid {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            return
        }

        if indexIsValid,
           let source = indexSet.first,
           let dli = Optional(cf[source]),
           !dli.lock {
            managedObjectContext.delete(dli)
        } else {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            security.isDeleteListViewValid = true
        }
    }

    func addItem(_ catItem: ListItem,
                 _ managedObjectContext: NSManagedObjectContext,
                 _ detailListItems: FetchedResults<ListItem>) {
        let newItem = ListItem(context: managedObjectContext)
        newItem.emoji = "✏️"
        newItem.name = "New Record"
        newItem.isParent = false
        newItem.uuidString = catItem.uuidString
        newItem.order = (detailListItems.last?.order ?? 0) + 1
        saveItems(managedObjectContext)
    }
}

extension ListView {
    func canCreate(catItem: ListItem) -> Button<Image>? {
        catItem.uuidString != "Stars" && catItem.uuidString != "Everything" ? New() : nil
    }

    func New() -> Button<Image> {
        Button(action: {listStruct.addItem(catItem, managedObjectContext, detailListItems)}) {Image(systemName: "plus")}
    }

    func moveItem(from source: IndexSet, to destination: Int) {
        listStruct.moveThisItem(source, destination, detailListItems, managedObjectContext, catItem, searchText)
    }

    func deleteItem(indexSet: IndexSet) {
        listStruct.deleteThisItem(indexSet, detailListItems, catItem, managedObjectContext, security, searchText)
    }
}

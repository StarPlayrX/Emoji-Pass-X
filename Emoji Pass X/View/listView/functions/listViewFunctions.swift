//
//  listViewFunctions.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ListView {

    func getList(_ a: [ListItem]) -> [ListItem] {
        a.filter( { "\($0.emoji)\($0.name)".lowercased().contains(searchText.lowercased()) || searchText.isEmpty } )
    }
    
    func canEdit() -> EditButton? {
        coldFilter(detailListItems).isEmpty ? nil : EditButton()
    }
    
    func canCreate() -> Button<Image>? {
        catItem.uuidString != "Stars" && catItem.uuidString != "Everything" ? New() : nil
    }
    
    func New() -> Button<Image> {
        Button(action: addItem) { Image(systemName: "plus") }
    }
    
    func reindex() {
        // reorder items
        coldFilter(detailListItems).enumerated().forEach { index, item in
            if item.order != index {
                item.order = index
            }
        }
    }
    
    func coldFilter(_ a: FetchedResults<ListItem>) -> [ListItem] {
        if catItem.uuidString == "Stars" {
            return a.filter( { $0.isParent == false && $0.star == true  })
        } else if catItem.uuidString == "Everything" {
            return a.filter( { $0.isParent == false  })
        } else {
            return a.filter( { $0.uuidString == catItem.uuidString &&  $0.isParent == false  })
        }
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        var item = coldFilter(detailListItems)
        item = getList(item)
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
        saveItems()
    }
    
    func deleteItem(indexSet: IndexSet) {
        var indexIsValid = false
        var cf = coldFilter(detailListItems)
        cf = getList(cf)
        
        if let source = indexSet.first {
            indexIsValid = cf.indices.contains(source)
        }
        
        if !indexIsValid {
            generator.notificationOccurred(.error)
            return
        }
        
        if indexIsValid,
           let source = indexSet.first,
           let dli = Optional(cf[source]),
           !dli.lock {
            managedObjectContext.delete(dli)
        } else {
            generator.notificationOccurred(.error)
            security.isDeleteListViewValid = true
        }
        saveItems()
    }
    
    func addItem() {
        let newItem = ListItem(context: managedObjectContext)
        newItem.emoji = pencil
        newItem.name = newRecord
        newItem.isParent = false
        newItem.uuidString = catItem.uuidString
        newItem.order = (detailListItems.last?.order ?? 0) + 1
        saveItems()
    }
    
    func saveItems() {
        // When saving a Context, always use the main thread to avoid collisions
        DispatchQueue.main.async() {
            if managedObjectContext.hasChanges {
                try? managedObjectContext.save()
            }
        }
    }
}

//
//  catViewStruct+Functions.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//
import SwiftUI
import CoreData
import Foundation

// https://www.raywenderlich.com/9335365-core-data-with-swiftui-tutorial-getting-started

protocol CatProtocol {
    func checkForCloudKit() -> Bool
    func setIsScreenDark()
    func showLockScreen(security: Security)
    func getCount(_ a: FetchedResults<ListItem>,_ b: ListItem) -> String
    func getList(_ a: [ListItem],_ searchText: String) -> [ListItem]
    func saveItems(_ managedObjectContext: NSManagedObjectContext)
    func addItem(_ managedObjectContext: NSManagedObjectContext,_ listItems: FetchedResults<ListItem>)

    func deleteThisItem(_ indexSet: IndexSet,
                        listItems: FetchedResults<ListItem>,
                        managedObjectContext: NSManagedObjectContext,
                        security: Security,
                        searchText: String)

    func moveThisItem(source: IndexSet,
                      destination: Int,
                      listItems: FetchedResults<ListItem>,
                      managedObjectContext: NSManagedObjectContext,
                      security: Security,
                      searchText: String)
}

struct CatStruct {
    func checkForCloudKit() -> Bool {
        FileManager.default.ubiquityIdentityToken == nil
    }

    func setIsScreenDark() {
        Global.isGlobalDark = UIScreen.main.traitCollection.userInterfaceStyle == .dark
    }

    func showLockScreen(security: Security) {
        security.lockScreen = true

        #if targetEnvironment(simulator)
            security.isSimulator = true
        #else
            security.isSimulator = false
            self.setIsScreenDark()
        #endif
    }

    func getCount(_ a: FetchedResults<ListItem>, _ b: ListItem) -> String {
        if b.uuidString == CategoryType.stars.rawValue {
            let j = a.filter {$0.star}.count
            return j > 0 ? String(j) : String()
        } else if b.uuidString == CategoryType.everything.rawValue {
            let j = a.filter {!$0.isParent}.count
            return j > 0 ? String(j) : String()
        } else {
            let j = a.filter {!$0.isParent && $0.uuidString == b.uuidString}.count
            return j > 0 ? String(j) : String()
        }
    }

    func getList(_ a: [ListItem], _ searchText: String) -> [ListItem] {
        a.filter({"\($0.emoji)\($0.name)".lowercased().contains(searchText.lowercased()) || searchText.isEmpty})
    }

    func saveItems(_ managedObjectContext: NSManagedObjectContext) {
        DispatchQueue.main.async() {
            if managedObjectContext.hasChanges {
                try? managedObjectContext.save()
            }
        }
    }

    func addItem(_ managedObjectContext: NSManagedObjectContext, _ listItems: FetchedResults<ListItem>) {

        // Todo: Create an Enum for these
        let cat = "🐛"
        let newCategory = "New Category"

        let newItem = ListItem(context: managedObjectContext)
        newItem.emoji = cat
        newItem.name = newCategory
        newItem.isParent = true
        newItem.uuidString = UUID().uuidString
        newItem.order = (listItems.last?.order ?? 0) + 1
        self.saveItems(managedObjectContext)
    }

    func deleteThisItem(_ indexSet: IndexSet,
                    listItems: FetchedResults<ListItem>,
                    managedObjectContext: NSManagedObjectContext,
                    security: Security,
                    searchText: String) {
       var cf = listItems.filter( { $0.isParent == true })
       cf = getList(cf, searchText)

       var indexIsValid = false

       if let source = indexSet.first{
           indexIsValid = cf.indices.contains(source)
       }

       if !indexIsValid {
           UINotificationFeedbackGenerator().notificationOccurred(.error)
       }

       if let source = indexSet.first, let listItem = Optional(cf[source]) {
           let gc = getCount(listItems, listItem)
           let uuidCount = 36

           if gc.isEmpty && listItem.uuidString.count == uuidCount {
               managedObjectContext.delete(listItem)
           } else if listItem.uuidString ==  CategoryType.stars.rawValue {
               managedObjectContext.delete(listItem)
           } else if listItem.uuidString ==  CategoryType.everything.rawValue {
               managedObjectContext.delete(listItem)
           } else {
               UINotificationFeedbackGenerator().notificationOccurred(.error)
               security.isValid = true
           }
           saveItems(managedObjectContext)
       }
   }

    func moveThisItem(source: IndexSet,
                      destination: Int,
                      listItems: FetchedResults<ListItem>,
                      managedObjectContext: NSManagedObjectContext,
                      security: Security,
                      searchText: String) {

        var category = listItems.filter( { $0.isParent == true })
        category = getList(category, searchText)

        category.move(fromOffsets: source, toOffset: destination)

        for i in 0..<category.count {
            category[i].order = i

            for j in 0..<listItems.count {
                if category[i].uuidString == listItems[j].uuidString {
                    listItems[j].order = category[i].order
                    break
                }
            }
        }
        saveItems(managedObjectContext)
    }
}

protocol CatViewProtocol {
    func deleteItem(indexSet: IndexSet)
    func moveItem(from source: IndexSet, to destination: Int)
}

extension CatView: CatViewProtocol {

    // indexSet is inferred
    func deleteItem(indexSet: IndexSet) {
        catStruct.deleteThisItem(
            indexSet,
            listItems: listItems,
            managedObjectContext: managedObjectContext,
            security: security,
            searchText: searchText
        )
    }

    func moveItem(from source: IndexSet, to destination: Int) {
        catStruct.moveThisItem(
            source: source,
            destination: destination,
            listItems: listItems,
            managedObjectContext: managedObjectContext,
            security: security,
            searchText: searchText)
    }
}

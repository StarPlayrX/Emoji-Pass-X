//
//  CatViewFunctions.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//
import SwiftUI
import CoreData

protocol CatProtocol {
    func checkForCloudKit() -> Bool
    func setIsScreenDark()
    func showLockScreen(security: Security)
    func getCount(_ a: FetchedResults<ListItem>,_ b: ListItem) -> String
    func getList(_ a: [ListItem],_ searchText: String) -> [ListItem]
    func saveItems(_ managedObjectContext: NSManagedObjectContext)
    func addItem(_ managedObjectContext: NSManagedObjectContext,_ listItems: FetchedResults<ListItem>)
}

struct CatStruct {
    func checkForCloudKit() -> Bool {
        FileManager.default.ubiquityIdentityToken == nil
    }

    func setIsScreenDark() {
        Global.isGlobalDark = UIScreen.main.traitCollection.userInterfaceStyle == .dark
    }

    func showLockScreen(security: Security) {
        // dismiss keyboard
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

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


}


extension CatView {

    func deleteItem(indexSet: IndexSet) {

        var cf = listItems.filter( { $0.isParent == true })
        cf = catStruct.getList(cf, searchText)

        var indexIsValid = false

        if let source = indexSet.first {
            indexIsValid = cf.indices.contains(source)
        }

        if !indexIsValid {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        }

        if let source = indexSet.first, let listItem = Optional(cf[source]) {
            let gc = catStruct.getCount(listItems, listItem)
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
            catStruct.saveItems(managedObjectContext)
        }
    }

    func moveItem(from source: IndexSet, to destination: Int) {
        var category = listItems.filter( { $0.isParent == true })
        category = catStruct.getList(category, searchText)
        
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
        catStruct.saveItems(managedObjectContext)
    }
    

}

//
//  CatViewFunctions.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//
import SwiftUI

protocol CatProtocol {
    func checkForCloudKit() -> Bool
    func setIsScreenDark()
    func showLockScreen(security: Security)
    func getCount(_ a: FetchedResults<ListItem>, _ b: ListItem) -> String
    func getList(_ a: [ListItem], _ searchText: String) -> [ListItem]
    func saveItems(_ managedObjectContext: NSManagedObjectContext)
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
}


extension CatView {

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
    
    func deleteItem(indexSet: IndexSet) {
        
        var cf = listItems.filter( { $0.isParent == true  })
        cf = catStruct.getList(cf, searchText)
        
        var indexIsValid = false
        
        if let source = indexSet.first {
            indexIsValid = cf.indices.contains(source)
        }
        
        if !indexIsValid {
            generator.notificationOccurred(.error)
        }
        
        if let source = indexSet.first, let listItem = Optional(cf[source]) {
            let gc = catStruct.getCount(listItems, listItem)
            
            if gc.isEmpty && listItem.uuidString.count == uuidCount {
                managedObjectContext.delete(listItem)
            } else if listItem.uuidString == stars {
                managedObjectContext.delete(listItem)
            } else if listItem.uuidString == everything {
                managedObjectContext.delete(listItem)
            } else {
                generator.notificationOccurred(.error)
                security.isValid = true
            }
            catStruct.saveItems(managedObjectContext)
        }
    }

    func addItem(_ managedObjectContext: NSManagedObjectContext) {
        let newItem = ListItem(context: managedObjectContext)
        newItem.emoji = cat
        newItem.name = newCategory
        newItem.isParent = true
        newItem.uuidString = UUID().uuidString
        newItem.order = (listItems.last?.order ?? 0) + 1
        catStruct.saveItems(managedObjectContext)
    }
}

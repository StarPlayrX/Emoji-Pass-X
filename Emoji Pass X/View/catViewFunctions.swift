//
//  CatViewFunctions.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension CatView {
    
    func getCount(_ a: FetchedResults<ListItem>, _ b: ListItem) -> String {
        if b.uuidString == stars {
            let j = a.filter {$0.star }.count
            return j > 0 ? String(j) : ""
            
        } else if b.uuidString == everything {
            let j = a.filter { !$0.isParent }.count
            return j > 0 ? String(j) : ""
            
        } else {
            let j = a.filter { !$0.isParent && $0.uuidString == b.uuidString }.count
            return j > 0 ? String(j) : ""
        }
    }
    
    func getList(_ a: [ListItem]) -> [ListItem] {
        a.filter( { "\($0.emoji)\($0.name)".lowercased().contains(searchText.lowercased()) || searchText.isEmpty } )
    }
 
    //MARK: See if iCloud is available
    func checkForCloudKit() -> Bool {
        FileManager.default.ubiquityIdentityToken != nil ? false : true
    }

    func moveItem(from source: IndexSet, to destination: Int) {
        var category = listItems.filter( { $0.isParent == true })
        category = getList(category)
        
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
        
        saveItems()
    }
    
    func deleteItem(indexSet: IndexSet) {
        
        var cf = listItems.filter( { $0.isParent == true  })
        cf = getList(cf)
        
        var indexIsValid = false
        
        if let source = indexSet.first {
            indexIsValid = cf.indices.contains(source)
        }
        
        if !indexIsValid {
            generator.notificationOccurred(.error)
        }
        
        if let source = indexSet.first, let listItem = Optional(cf[source]) {
            let gc = getCount(listItems, listItem)
            
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
            
            saveItems()
        }
    }
    
    
    func setIsScreenDark() {
        isGlobalDark = UIScreen.main.traitCollection.userInterfaceStyle == .dark
    }
    
    func showLockScreen() {
        security.lockScreen = true
        
     
        #if targetEnvironment(simulator)
            security.isSimulator = true
        #else
            security.isSimulator = false
            setIsScreenDark()
        #endif
    }

    func addItem() {
        let newItem = ListItem(context: managedObjectContext)
        newItem.emoji = cat
        newItem.name = newCategory
        newItem.isParent = true
        newItem.uuidString = UUID().uuidString
        newItem.order = (listItems.last?.order ?? 0) + 1
        saveItems()
    }
    
    func saveItems() {
        DispatchQueue.main.async() {
            if managedObjectContext.hasChanges {
                try? managedObjectContext.save()
            }
        }
    } 
}

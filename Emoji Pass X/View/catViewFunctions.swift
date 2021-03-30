//
//  CatViewFunctions.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
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
            var duplicateStars = false
            var duplicateEverything = false
            
            let starLite = listItems.filter( { $0.isParent == true && $0.uuidString == stars }).count
   
            if starLite > 1 {
                duplicateStars = true
            }
            
            let everythingBagel = listItems.filter( { $0.isParent == true && $0.uuidString == everything }).count

            if everythingBagel > 1 {
                duplicateEverything = true
            }
            
            let gc = getCount(listItems, listItem)
            
            if gc.isEmpty && listItem.uuidString.count == uuidCount {
                managedObjectContext.delete(listItem)
            } else if listItem.uuidString == stars && duplicateStars  {
                managedObjectContext.delete(listItem)
            } else if listItem.uuidString == everything && duplicateEverything {
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
    
    
    func freshCats() {
        #if !targetEnvironment(simulator)
            DispatchQueue.main.async() {
                let starLite = listItems.filter( { $0.isParent == true && $0.uuidString == stars })
                
                if starLite.isEmpty {
                    addStars()
                }
                
                let everythingBagel = listItems.filter( { $0.isParent == true && $0.uuidString == everything })
                
                if everythingBagel.isEmpty {
                    addEverything()
                }
            
                saveItems()
            }
        #endif
            setIsScreenDark()
    }
    
    func addStars() {
        let newItem = ListItem(context: managedObjectContext)
        newItem.emoji = star
        newItem.name = stars
        newItem.isParent = true
        newItem.uuidString = stars
        newItem.order = (listItems.last?.order ?? 0) + 1
        saveItems()
    }
    
    func addEverything() {
        let newItem = ListItem(context: managedObjectContext)
        newItem.emoji = magnifier
        newItem.name = everything
        newItem.isParent = true
        newItem.uuidString = everything
        newItem.order = (listItems.last?.order ?? 0) + 1
        saveItems()
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if managedObjectContext.hasChanges {
                try? managedObjectContext.save()
            }
        }
        
        setIsScreenDark()
    }
    
    /*func fetchItems() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if managedObjectContext.hasChanges {
                
                do {
                    listItems = try managedObjectContext.fetch(ListItem.getFetchRequest() ) as [ListItem]
                } catch  {
                    print(error)
                }
            }
        }
        
        setIsScreenDark()
    }*/
    
  
}
// (fetchRequest: ListItem.getFetchRequest()) var listItems: FetchedResults<ListItem>

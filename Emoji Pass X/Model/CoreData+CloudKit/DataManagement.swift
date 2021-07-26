//
//  DataManagement.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/24/21.
//

import CoreData

// Apple CoreData and CloudKit
// https://developer.apple.com/documentation/coredata/mirroring_a_core_data_store_with_cloudkit/setting_up_core_data_with_cloudkit

// SchwiftyUI
// https://schwiftyui.com/swiftui/using-cloudkit-in-swiftui/

class DataManagement {

    // Sets up our Persistent Container for CloudKit + CoreData
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "passlist")
    
        guard
            let description = container.persistentStoreDescriptions.first
        else {
            return container
        }
        
        description.setOption(true as NSObject, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        NotificationCenter.default.addObserver(self, selector: #selector(self.processUpdate), name: .NSManagedObjectContextObjectsDidChange, object: nil)
        
        return container
    }()
        
    // MARK: - Not sure when this is invoked, We save manually on the Main Queue
    lazy var operationQueue: OperationQueue = {
       var queue = OperationQueue()
        queue.maxConcurrentOperationCount = 100
        return queue
    }()

    
    // MARK: - Core Data Saving support
    @objc func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {try? context.save()}
    }
    
    // MARK: - Process Update
    @objc func processUpdate(notification: NSNotification) {
        operationQueue.addOperation {
            let context = self.persistentContainer.viewContext
            context.performAndWait {
       
                if context.hasChanges { try? context.save()
                    context.refreshAllObjects()
                }
            }
        }
    }
}

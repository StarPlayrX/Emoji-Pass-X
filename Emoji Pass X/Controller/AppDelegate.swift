//
//  AppDelegate.swift
//  Emoji Pass X
//
//  Created by StarPlayrX on 2/27/21.
//

import UIKit

import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Turns off UI Contraint warnings
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        Thread.sleep(forTimeInterval: 0)
             // Override point for customization after application launch.
         return true
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        
        let container = NSPersistentCloudKitContainer(name: "passlist")
        
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("No Descriptions found")
        }
        
        description.setOption(true as NSObject, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.processUpdate), name: .NSPersistentStoreRemoteChange, object: nil)
        
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                // do something
                try? context.save()
            }
        }
    }
    
    @objc
    func processUpdate(notification: NSNotification) {
        operationQueue.addOperation {
            // get our context
            let context = self.persistentContainer.newBackgroundContext()
            context.performAndWait {
       
                // save if we need to save
                if context.hasChanges {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        // do something
                        try? context.save()
                    }
                 
                }
            }
            
        }
    }
    
    
    lazy var operationQueue: OperationQueue = {
       var queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

}




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

    override func buildMenu(with builder: UIMenuBuilder) {
        super.buildMenu(with: builder)

        builder.remove(menu: .services)
        builder.remove(menu: .format)
        builder.remove(menu: .toolbar)
        
        let refreshCommand = UIKeyCommand(input: "S", modifierFlags: [.command], action: #selector(save))
        refreshCommand.title = "Save"
        let saveDataMenu = UIMenu(title: "Save", image: nil, identifier: UIMenu.Identifier("Save"), options: .displayInline, children: [refreshCommand])
        builder.insertChild(saveDataMenu, atStartOfMenu: .file)
    }
    
    
    //MARK: Save Object
    @objc func save() {
        NotificationCenter.default.post(name: .save, object: nil)
    }

    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //Turns off UI Contraint warnings
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        
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
    @objc
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
                        context.refreshAllObjects()
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




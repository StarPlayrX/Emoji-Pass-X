//
//  AppDelegate.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 2/27/21.
//

import UIKit

import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    override func buildMenu(with builder: UIMenuBuilder) {
        super.buildMenu(with: builder)
        
        let refreshCommand = UIKeyCommand(input: "S", modifierFlags: [.command], action: #selector(save))
        refreshCommand.title = "Save"
        let saveDataMenu = UIMenu(title: "Save", image: nil, identifier: UIMenu.Identifier("Save"), options: .displayInline, children: [refreshCommand])
        builder.insertChild(saveDataMenu, atStartOfMenu: .file)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        GlobalVariables.isGlobalDark = UIScreen.main.traitCollection.userInterfaceStyle == .dark
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
    
        
    //MARK: CloudKit Notifications
    @objc func save() {
        NotificationCenter.default.post(name: .save, object: nil)
    }

    @objc func refresh() {
        NotificationCenter.default.post(name: .refresh, object: nil)
    }

    // MARK: - Core Data Saving support
    @objc func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges { try? context.save() }
    }

    @objc func processUpdate(notification: NSNotification) {
        operationQueue.addOperation {
            // get our context
            let context = self.persistentContainer.viewContext
            context.performAndWait {
                // save if we need to save
                if context.hasChanges {
                    try? context.save()
                    context.refreshAllObjects()
                }
            }
        }
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        
        let container = NSPersistentCloudKitContainer(name: "passlist")
        guard let description = container.persistentStoreDescriptions.first else { fatalError("No Descriptions found") }
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

    // MARK: - Max concurrency
    lazy var operationQueue: OperationQueue = {
       var queue = OperationQueue()
        queue.maxConcurrentOperationCount = 100
        return queue
    }()

}

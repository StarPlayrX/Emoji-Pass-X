//
//  AppDelegate.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 2/27/21.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    override func buildMenu(with builder: UIMenuBuilder) {
        // Setup save menu
        if UIDevice.current.userInterfaceIdiom == .mac {
            super.buildMenu(with: builder)
            let refreshCommand = UIKeyCommand(input: "S", modifierFlags: [.command], action: #selector(save))
            refreshCommand.title = "Save"
            let saveDataMenu = UIMenu(title: "Save", image: nil, identifier: UIMenu.Identifier("Save"), options: .displayInline, children: [refreshCommand])
            builder.insertChild(saveDataMenu, atStartOfMenu: .file)
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Autolayout will complain less
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    //MARK: Save Object
    @objc func save() {
        NotificationCenter.default.post(name: .save, object: nil)
    }
}

//
//  AppDelegate.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 2/27/21.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: Save Object
    @objc func save() {
        NotificationCenter.default.post(name: .save, object: nil)
    }
    
    func buildMenu(_ builder: UIMenuBuilder){
        if UIDevice.current.userInterfaceIdiom == .mac {
            
            let input = "S"
            let saves = "Save"
            
            let refreshCommand = UIKeyCommand(
                input: input,
                modifierFlags: [.command],
                action: #selector(save)
            )
            
            refreshCommand.title = saves
            
            let saveDataMenu = UIMenu(
                title: saves,
                image: nil,
                identifier: UIMenu.Identifier(saves),
                options: .displayInline,
                children: [refreshCommand]
            )
            
            builder.insertChild(saveDataMenu, atStartOfMenu: .file)
        }
    }
    
    override func buildMenu(with builder: UIMenuBuilder) {
        super.buildMenu(with: builder)
        
        // Setup save menu
        buildMenu(builder)
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
    
  
}

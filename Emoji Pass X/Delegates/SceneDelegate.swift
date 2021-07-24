//
//  SceneDelegate.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 2/27/21.
//
import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let dataMgt = DataManagement()
        let managedObjectContext = dataMgt.persistentContainer.viewContext
        let contentView = CatView().environment(\.managedObjectContext, managedObjectContext)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            windowScene.sizeRestrictions?.minimumSize = CGSize(width: 640, height: 640)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {
        isGlobalDark = UIScreen.main.traitCollection.userInterfaceStyle == .dark
        hideKeyboard()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        isGlobalDark = UIScreen.main.traitCollection.userInterfaceStyle == .dark
        hideKeyboard()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        isGlobalDark = UIScreen.main.traitCollection.userInterfaceStyle == .dark
        hideKeyboard()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        isGlobalDark = UIScreen.main.traitCollection.userInterfaceStyle == .dark
        hideKeyboard()
    }
    
    func hideKeyboard() {
       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}



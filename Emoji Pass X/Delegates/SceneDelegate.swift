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
            windowScene.sizeRestrictions?.minimumSize = CGSize(width: 900, height: 600)

            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func transitionAppState() {
        Global.isGlobalDark = UIScreen.main.traitCollection.userInterfaceStyle == .dark
        
        // Hide Keyboard on iOS devices
        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .phone {
            HideKeys().hideKeyboard()
        }
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        transitionAppState()
    }

}



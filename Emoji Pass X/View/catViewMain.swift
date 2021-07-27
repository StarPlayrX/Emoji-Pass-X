//
//  catViewMain.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/21/21.
//
import SwiftUI

extension CatView {
    func catViewMain() -> some View {
        ZStack {
            NavigationView {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    
                    // 1 iPad Panel
                    catViewiPadPanel()
                    
                    // 2 mainView
                    // This allows Wider column on iPad. Workaround for SideBar bug.
                    catViewUI()
                        .onDisappear(perform: {catStruct.saveItems(managedObjectContext)})
                        .onAppear(perform: {catStruct.saveItems(managedObjectContext)})
                    
                    // 3 Dummy Detail View
                    Text(String())
                } else {
                    
                    // 1 mainView
                    catViewUI()
                }
            }
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
        .environmentObject(security)
        .onAppear(perform: {catStruct.saveItems(managedObjectContext)})
        .onDisappear(perform: {catStruct.saveItems(managedObjectContext)})
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            catStruct.showLockScreen(security: security)
            DispatchQueue.main.async() {
                catStruct.saveItems(managedObjectContext)
                hideKeyboard()
                catStruct.setIsScreenDark()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            DispatchQueue.main.async() {
                catStruct.saveItems(managedObjectContext)
                hideKeyboard()
                catStruct.setIsScreenDark()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .save)) { _ in
            DispatchQueue.main.async() {
                security.isEditing = false
                security.catLock = true
                catStruct.saveItems(managedObjectContext)
                refreshAllObjects()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .refresh)) { _ in
            DispatchQueue.main.async() {
                security.isEditing = false
                security.catLock = true
                refreshAllObjects()
            }
        }
    }
}

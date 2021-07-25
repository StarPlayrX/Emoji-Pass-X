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
                        .onDisappear(perform: saveItems)
                        .onAppear(perform: saveItems)
                    
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
        .onAppear(perform: saveItems)
        .onDisappear(perform: saveItems)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            showLockScreen()
            DispatchQueue.main.async() {
                saveItems()
                hideKeyboard()
                setIsScreenDark()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            DispatchQueue.main.async() {
                saveItems()
                hideKeyboard()
                setIsScreenDark()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .save)) { _ in
            DispatchQueue.main.async() {
                security.isEditing = false
                security.catLock = true
                saveItems()
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

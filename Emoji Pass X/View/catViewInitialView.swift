//
//  catViewInitialView.swift
//  Emoji Pass X
//
//  Created by M1 on 3/31/21.
//

import SwiftUI

extension CatView {
    
    func refreshAllObjects() {
        managedObjectContext.refreshAllObjects()
    }
    
    
    
    func intialView() -> some View {
        
        Group {
            if security.lockScreen  {
                catViewLockStack()
                    .onAppear(perform: showLockScreen)
                    
            } else {
                ZStack {
                    NavigationView {
                        catViewStack()
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
                        setIsScreenDark()
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    DispatchQueue.main.async() {
                        saveItems()
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
                        print("refresh")
                    }
                }
            }
        }
    }
}

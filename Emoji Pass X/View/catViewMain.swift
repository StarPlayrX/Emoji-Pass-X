//
//  catViewMain.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/21/21.
//


import SwiftUI
import CoreData

//MARK: lockStack

extension CatView {
    func catViewMain() -> some View {
        ZStack {
            NavigationView {
            
                //MARK: Allows a wider view on the middle column
                if UIDevice.current.userInterfaceIdiom == .pad {
                    catViewPad()
                } else {
                    catViewStack()
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
                print("refresh")
            }
        }
    }
}

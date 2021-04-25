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
                    
                        //MARK: Allows a wider view on the middle column
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            VStack {
                                
                                Group {
                                    
                                    Text("Emoji Pass X").font(.largeTitle).minimumScaleFactor(0.75)
                                    
                                    HStack {
                                        
                                        Image("Emoji Pass X_logo4")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 230.0,height:230)
                                            .background(Color.clear)
                                    }.overlay (
                                        RoundedRectangle(cornerRadius: 48)
                                            .stroke(  isGlobalDark  ? Color.gray : Color.white, lineWidth: 2)
                                    )
                                    
                                    Text(copyright).font(.callout).minimumScaleFactor(0.75).padding(.leading, 30).padding(.trailing, 30).padding(.top, 10).padding(.bottom, 10)
                                    Text("The premiere password manager for macOS, iPadOS and iOS").font(.callout).minimumScaleFactor(0.75).multilineTextAlignment(.center).padding(.leading, 30).padding(.trailing, 30).padding(.top, 20).padding(.bottom, 10)
                                    Text("Your data is stored privately in your own iCloud account.").font(.callout).minimumScaleFactor(0.75).multilineTextAlignment(.center).padding(.leading, 30).padding(.trailing, 30).padding(.top, 20).padding(.bottom, 10)
                                }
                                Spacer()
                            }
                            
                            catViewStack() //allows Wider column on iPad (workaround for SideBar bug)
                                .onDisappear(perform: saveItems)
                                .onAppear(perform: saveItems)
                                
                            Text("")//Dummy Detail View
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
    }
}


/*
 
 NotificationCenter.default
   .publisher(for: .NSManagedObjectContextDidSave, object: backgroundMoc)
   .sink(receiveValue: { notification in
     // handle changes
   })
 
 
 */

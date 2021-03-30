//
//  CatView.swift
//  Emoji Pass X
//
//  Created by StarPlayrX on 2/27/21.
//
import SwiftUI
import CoreData
import AuthenticationServices


struct CatView: View {
    @FetchRequest(fetchRequest: ListItem.getFetchRequest()) var listItems: FetchedResults<ListItem>
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var showingAlert = false
    @State var searchText: String = ""
    @State var isSearching = false
    
    @StateObject var security = Security()
    
    
    /*  request.entity = ListItem.entity()
     request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)] */
    let name = "Name"
    let emoji = ":)"
    let newCategory = "New Category"
    
    let cat = "🐛"
    let pencil = "✏️"
    let star = "⭐️"
    let magnifier = "🔍"
    
    let stars = "Stars"
    let everything = "Everything"
    let uuidCount = 36
    
    let generator = UINotificationFeedbackGenerator()
    let copyright = "© 2021 Todd Bruss"
    
    //MARK: Main Body Content View
    var body: some View {
        
        
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
            .onAppear(perform: freshCats)
            .onDisappear(perform: freshCats)
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                showLockScreen()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    saveItems()
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                DispatchQueue.main.async() {
                    freshCats()
                }
                
                
            }
            .onReceive(NotificationCenter.default.publisher(for: .save)) { _ in
                DispatchQueue.main.async() {
                    security.isEditing = false
                    security.catLock = true
                    saveItems()
                }
            }
        }
    }
}

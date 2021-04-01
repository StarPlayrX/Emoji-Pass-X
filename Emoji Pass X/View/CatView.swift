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
        intialView()
    }
}

//
//  CatView.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 2/27/21.
//
import SwiftUI

// https://www.hackingwithswift.com/quick-start/swiftui/two-way-bindings-in-swiftui Two Way Bindings
// https://samwize.com/2020/03/27/how-to-use-binding-in-swiftui/ Bindings in depth
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
    let stars = "Stars"
    let everything = "Everything"
    let uuidCount = 36
    let generator = UINotificationFeedbackGenerator()
    let copyright = "© 2021 Todd Bruss"
    
    let cat = "🐛"
    let pencil = "✏️"
    let star = "⭐️"
    let magnifier = "🔍"
    
    //MARK: Main Body Content View
    var body: some View {
        intialView()
    }
}


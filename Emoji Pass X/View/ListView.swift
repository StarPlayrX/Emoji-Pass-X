//
//  ContentView.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 2/27/21.
//

import SwiftUI

struct ListView: View {
    
    // CoreData + CloudKit
    @FetchRequest(fetchRequest: ListItem.getFetchRequest())
    var detailListItems: FetchedResults<ListItem>
    @Environment(\.managedObjectContext) var managedObjectContext

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var catItem: ListItem
    @EnvironmentObject var security: Security
    
    let name = "Name"
    let emoji = ":)"
    let newRecord = "New Record"
    let pencil = "✏️"
    
    @State var searchText: String = String()
    @State var isSearching = false
    @State var leader = CGFloat.zero
    
    let generator = UINotificationFeedbackGenerator()
    
    init(catItem: ListItem) {
        self.catItem = catItem
    }

    //MARK: BODY
    var body: some View {
        listView()
    }
}

//
//  ContentView.swift
//  Emoji Pass X
//
//  Created by StarPlayrX on 2/27/21.
//

import SwiftUI
import CoreData
import AuthenticationServices

struct ListView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(fetchRequest: ListItem.getFetchRequest()) var detailListItems: FetchedResults<ListItem>
    @ObservedObject var catItem: ListItem
    @EnvironmentObject var security: Security
    
    let name = "Name"
    let emoji = ":)"
    let newRecord = "New Record"
    let pencil = "✏️"
    
    @State var searchText: String = ""
    @State var isSearching = false
    @State var leader = CGFloat.zero
    
    let generator = UINotificationFeedbackGenerator()
    
    init(catItem: ListItem) {
        self.catItem = catItem
    }

    //MARK: BODY
    var body: some View {
        detailListView()
    }
}

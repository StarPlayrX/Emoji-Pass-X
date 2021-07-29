//
//  ContentView.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 2/27/21.
//

import SwiftUI

struct ListView: View {
    
    // CoreData + CloudKit
    var detailListItems: FetchedResults<ListItem>
    
    @Environment(\.managedObjectContext) var managedObjectContext

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var catItem: ListItem
    @EnvironmentObject var security: Security

    let listStruct = ListStruct()

    @State var searchText: String = String()
    @State var isSearching = false

    init(catItem: ListItem, detailListItems: FetchedResults<ListItem>) {
        self.catItem = catItem
        self.detailListItems = detailListItems
    }

    //MARK: BODY
    var body: some View {
        listView(detailListItems: detailListItems)
    }
}

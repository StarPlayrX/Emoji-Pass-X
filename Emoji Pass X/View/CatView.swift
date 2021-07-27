//
//  CatView.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 2/27/21.
//
import SwiftUI

// Creating and Combining Views
// https://developer.apple.com/tutorials/swiftui/creating-and-combining-views

// Two Way Bindings
// https://www.hackingwithswift.com/quick-start/swiftui/two-way-bindings-in-swiftui

// Bindings in depth
// https://samwize.com/2020/03/27/how-to-use-binding-in-swiftui/

struct CatView: View {
    
    //CoreData + CloudKit
    @FetchRequest(fetchRequest: ListItem.getFetchRequest())
    var listItems: FetchedResults<ListItem>
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showingAlert = false
    @State var searchText: String = String()
    @State var isSearching = false
    @State var updater: Bool = false

    @StateObject var security = Security()

    let catStruct = CatStruct()

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

var mockView: some View {
    Group {
        VStack {
            Text("Emoji Pass  X").font(.largeTitle).minimumScaleFactor(0.75).padding(.top, 50)

            HStack {
                Image("Emoji Pass X_logo4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 230.0, height: 230)
                    .background(Color.clear)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 48)
                    .stroke(Color.gray, lineWidth: 2)
            )

            Text("© 2021 Todd Bruss").font(.callout).minimumScaleFactor(0.75).padding(.top, 10)
                .padding(.bottom, 25)
            Button("Continue") {}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        mockView
    }
}

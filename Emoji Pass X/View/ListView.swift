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
    @FetchRequest(fetchRequest: ListItem.getFetchRequest()) var detailListItemss: FetchedResults<ListItem>
    @ObservedObject var catItem: ListItem
    //@EnvironmentObject var security: Security
    
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
    
  
    
    //MARK: https://www.youtube.com/watch?v=vgvbrBX2FnE (Search Bar How to Reference in SwiftUI)
    
    func getList(_ a: [ListItem]) -> [ListItem] {
        a.filter( { "\($0.emoji)\($0.name)".lowercased().contains(searchText.lowercased()) || searchText.isEmpty } )
    }
    
    //MARK: searchStack
    func searchStack() -> some View {
        return HStack {
            TextField("Search", text: $searchText)
                .padding(.leading, iPhoneXSearch())
                .padding(.trailing, 64)
                .listRowBackground(Color(UIColor.systemBackground))
        }
        .listRowBackground(Color(UIColor.systemBackground))
        .padding(.leading, 8)
        
        .onTapGesture( perform: {
            isSearching = true
        })
        .overlay (
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(.leading, iPhoneXMag())
                
                Spacer()
                    .padding(.trailing, 16)
                if isSearching {
                    Button(action: {searchText = ""; hideKeyboard()}, label: {
                        Image(systemName: "xmark")
                            .padding(.vertical)
                            .padding(.trailing, 2)
                    })
                }
            }
        )
    }
    
    func forEach(_ a:  FetchedResults<ListItem>) -> some View {
        ForEach( getList(coldFilter(a) ) , id: \.self) { item in
            NavigationLink(destination: ItemView(catItem: catItem, listItem: item)) {
                if item.emoji.isEmpty || item.name.isEmpty {
                    Text("\(pencil) \(newRecord)")
                        .padding(.trailing, 18)
                        .padding(.leading, iPhoneXCell())
                        
                } else {
                    Text("\(item.emoji) \(item.name)")
                        .padding(.trailing, 18)
                        .padding(.leading, iPhoneXCell())

                }
            }
            .isDetailLink(true)
            .overlay (
                HStack {
                    Spacer()
                    if item.lock {
                        Image(systemName: "lock")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 18)
                    }
                }
            )
            .font(.title)
            .listRowBackground(Color(UIColor.systemBackground))
            
        }
        .onDelete(perform: deleteItem)
        .onMove(perform: moveItem)
        .padding(.trailing, 0)
        .frame(height:40)
    }
    
    func listViewStack() -> some View {
        return VStack {
            List {
                searchStack()
                forEach(detailListItemss)
            }
            .padding(.leading, iPhoneXLeading())
            .listStyle(PlainListStyle())
        }
        
        .navigationBarTitle(catItem.name, displayMode: .inline)
        .toolbar {
            
          
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                canEdit()

                canCreate()
            }
        }
    }
    
    
    func detailListView() -> some View {
        return ZStack {
            listViewStack()
        }
        //.environmentObject(security)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                saveItems()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    
    //MARK: BODY
    var body: some View {
        detailListView()
            .onDisappear(perform: { saveItems() })
            .onAppear(perform: {  saveItems() })
            .onAppear(perform: {  saveItems() })

    }
    
    
    func canEdit() -> EditButton? {
        
        let cf = coldFilter(detailListItemss)
        
        if !cf.isEmpty {
            return EditButton()
        }
        
        return nil
    }
    
    func canCreate() -> Button<Image>? {
        if catItem.uuidString != "Stars" && catItem.uuidString != "Everything" {
            return New()
        }
        
        return nil
    }
    
    func New() -> Button<Image> {
        return   Button(action: addItem)
            { Image(systemName: "plus") }
    }
    
    
    func reindex() {
        // reorder items
        
        let x = coldFilter(detailListItemss);
        
        x.enumerated().forEach { index, item in
            if item.order != index {
                item.order = index
            }
        }
    }
    
    func coldFilter(_ a: FetchedResults<ListItem>) -> [ListItem] {
        
        if catItem.uuidString == "Stars" {
            return a.filter( { $0.isParent == false && $0.star == true  })
        } else if catItem.uuidString == "Everything" {
            return a.filter( { $0.isParent == false  })
        } else {
            return a.filter( { $0.uuidString == catItem.uuidString &&  $0.isParent == false  })
        }
        
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        
        var item = coldFilter(detailListItemss)
        item = getList(item)
        
        item.move(fromOffsets: source, toOffset: destination)
        
        for i in 0..<item.count {
            item[i].order = i
            
            for j in 0..<detailListItemss.count {
                if item[i].objectID == detailListItemss[j].objectID {
                    detailListItemss[j].order = item[i].order
                    break
                }
            }
        }
        
        saveItems()
    }
    
    func deleteItem(indexSet: IndexSet) {
        
        var cf = coldFilter(detailListItemss)
        
        cf = getList(cf)
        
        var indexIsValid = false
        
        if let source = indexSet.first {
            indexIsValid = cf.indices.contains(source)
        }
        
        if !indexIsValid {
            generator.notificationOccurred(.error)
            return
        }
        
        if indexIsValid, let source = indexSet.first, let detailListItems = Optional(cf[source]), !detailListItems.lock {
            managedObjectContext.delete(detailListItems)
        } else {
            generator.notificationOccurred(.error)
        }
        
        saveItems()
    }
    
    func addItem() {
        let newItem = ListItem(context: managedObjectContext)
        newItem.emoji = pencil
        newItem.name = newRecord
        newItem.isParent = false
        newItem.uuidString = catItem.uuidString
        newItem.order = (detailListItemss.last?.order ?? 0) + 1
        saveItems()
    }
    
    func saveItems() {
        
        DispatchQueue.main.async() {
            // do something
            if managedObjectContext.hasChanges {
                try? managedObjectContext.save()
            }
        }
    }
}

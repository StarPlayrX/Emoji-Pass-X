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
    
    @StateObject var security = Security()
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ListItem.getFetchRequest()) var listItems: FetchedResults<ListItem>
    let name = "Name"
    let emoji = ":)"
    let newCategory = "New Category"
    
    let cat = "🐛"
    let pencil = "✏️"
    let star = "⭐️"
    let magnifier = "🔍"
    
    let stars = "Stars"
    let everything = "Everything"
    
    @State var searchText: String = ""
    @State var catLock: Bool = true
    
    @State var isSearching = false
    let generator = UINotificationFeedbackGenerator()
    
    
    
    //MARK: https://www.youtube.com/watch?v=vgvbrBX2FnE (Search Bar How to Reference in SwiftUI)
    
    func getCount(_ a: FetchedResults<ListItem>, _ b: ListItem) -> String {
        
        if b.uuidString == stars {
            let j = a.filter {$0.star }.count
            return j > 0 ? String(j) : ""
            
        } else if b.uuidString == everything {
            let j = a.filter { !$0.isParent }.count
            return j > 0 ? String(j) : ""
            
        } else {
            let j = a.filter { !$0.isParent && $0.uuidString == b.uuidString }.count
            return j > 0 ? String(j) : ""
        }
        
    }
    
    func getList(_ a: [ListItem]) -> [ListItem] {
        a.filter( { "\($0.emoji)\($0.name)".lowercased().contains(searchText.lowercased()) || searchText.isEmpty } )
    }
    
    
    //MARK: searchStack
    func searchStack() -> some View {
        return HStack {
            TextField("Search", text: $searchText)
                .padding(.leading, 32)
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
                    .padding(.leading, 8)
                
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
    
    //MARK: catViewStack
    func catViewStack() -> some View {
        return VStack {
            
            let category = listItems.filter( { $0.isParent == true })
            
            List {
                
                searchStack()
                
                ForEach( getList(category), id: \.self ) { item in
                    
                    
                    if !catLock {
                        
                        //let gc = getCount(a: listItems, b: item)
                        NavigationLink(destination: CatEditView(listItem: item)) {
                            Text("\(pencil) \(item.name)")
                                .padding(.trailing, 18)
                                .font(.title)
                            
                        }
                        
                        .overlay (
                            HStack {
                                Spacer()
                                Text("\(getCount(listItems,item))")
                                    .padding(.trailing, 18)
                            }
                        )
                        
                    } else if item.name == newCategory  {
                        
                        //let gc = getCount(a: listItems, b: item)
                        NavigationLink(destination: CatEditView(listItem: item)) {
                            Text("\(cat) \(newCategory)")
                                .padding(.trailing, 18)
                                .font(.title)
                        }
                        .overlay (
                            HStack {
                                Spacer()
                                Text("\(getCount(listItems,item))")
                                    .padding(.trailing, 18)
                                
                            }
                        )
                    } else {
                        //let gc = getCount(a: listItems, b: item)
                        NavigationLink(destination: ListView(catItem: item)) {
                            Text("\(item.emoji) \(item.name)")
                                .padding(.trailing, 18)
                                .font(.title)
                        }
                        .isDetailLink(false)
                        .overlay (
                            HStack {
                                Spacer()
                                Text("\(getCount(listItems,item))")
                                    .padding(.trailing, 18)
                                
                            }
                        )
                    }
                    
                }
                .onDelete(perform: deleteItem)
                .onMove(perform: moveItem)
                .padding(.trailing, 0)
                .frame(height:40)
            }
            .padding(.leading, -16)
            .listStyle(PlainListStyle())
        }
        .navigationBarTitle("Categories", displayMode: .inline)
        .toolbar {
            
            ToolbarItemGroup(placement: .navigationBarLeading) {
                
               /* Button(action: { saveItems();security.lockScreen = true })
                {
                    Image(systemName: "lock.shield.fill")
                }*/
                
                EditButton()
                
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                
                Button(action: { catLock = !catLock })
                {
                    if !catLock {
                        Image(systemName: "lock.open")
                    } else {
                        Image(systemName: "lock.fill")
                    }
                }
                
                Button(action: addItem)
                    { Image(systemName: "plus") }
            }
        }
    }
    
    //MARK: lockStack
    func lockStack() -> some View {
        return VStack {
            HStack {
                
                Image("Emoji Pass X_logo4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 230.0,height:230)
                    .background(Color.black)
            }
            .padding(.top, 100)
            
            SignInWithAppleButton(.signIn,
                                  onRequest: { (request) in
                                    //Set up request
                                    //MARK: We are only using Sign on with Apple as a controlled Gateway
                                  },
                                  onCompletion: { (result) in
                                    switch result {
                                    case .success(_):
                                        //MARK: print(authorization)
                                        //MARK: to use authorization add: let authorization to (_)
                                        security.lockScreen = false
                                        break
                                    case .failure(let error):
                                        print(error)
                                        break
                                    }
                                  })
                .padding(.bottom, 100)
                .background(Color.black)
            
        }
        .signInWithAppleButtonStyle(.black)
        .background(Color.black)
    }
    
    
    
    func moveItem(from source: IndexSet, to destination: Int) {
        
        var category = listItems.filter( { $0.isParent == true })
        category = getList(category)
        
        category.move(fromOffsets: source, toOffset: destination)
        
        for i in 0..<category.count {
            category[i].order = i
            
            for j in 0..<listItems.count {
                if category[i].uuidString == listItems[j].uuidString {
                    listItems[j].order = category[i].order
                    break
                }
            }
        }
    }
    
    func deleteItem(indexSet: IndexSet) {
        
        var cf = listItems.filter( { $0.isParent == true  })
        cf = getList(cf)
        
        var indexIsValid = false
        
        if let source = indexSet.first {
            indexIsValid = cf.indices.contains(source)
        }
        
        if !indexIsValid {
            generator.notificationOccurred(.error)
            return
        }
        
        if let source = indexSet.first, let listItem = Optional(cf[source]) {
            
            let gc = getCount(listItems,listItem)
            
            if (gc.isEmpty && listItem.uuidString != stars && listItem.uuidString != everything) {
                managedObjectContext.delete(listItem)
            } else {
                //MARK: Haptic Feedback Reference: https://gist.github.com/Harry-Harrison/e4217a6d8c4cfbee1aa5128c4491a149
                generator.notificationOccurred(.error)
            }
        }
        
        saveItems()
    }
    

    func freshCats() {
        let starLite = listItems.filter( { $0.isParent == true && $0.uuidString == stars })
        
        if starLite.isEmpty {
            addStars()
        }
        
        let everythingBagel = listItems.filter( { $0.isParent == true && $0.uuidString == everything })
        
        if everythingBagel.isEmpty {
            addEverything()
        }
    
        saveItems()
    }
    
    func addStars() {
        let newItem = ListItem(context: managedObjectContext)
        newItem.emoji = star
        newItem.name = stars
        newItem.isParent = true
        newItem.uuidString = stars
        newItem.order = (listItems.last?.order ?? 0) + 1
        saveItems()
    }
    
    func addEverything() {
        let newItem = ListItem(context: managedObjectContext)
        newItem.emoji = magnifier
        newItem.name = everything
        newItem.isParent = true
        newItem.uuidString = everything
        newItem.order = (listItems.last?.order ?? 0) + 1
        saveItems()
    }
    
    func addItem() {
        let newItem = ListItem(context: managedObjectContext)
        newItem.emoji = cat
        newItem.name = newCategory
        newItem.isParent = true
        newItem.uuidString = UUID().uuidString
        newItem.order = (listItems.last?.order ?? 0) + 1
        saveItems()
    }
    
    func saveItems() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if managedObjectContext.hasChanges {
                try? managedObjectContext.save()
            }
        }
    }
    
    
    //MARK: Main Body Content View
    var body: some View {
        if security.lockScreen {
            lockStack()
        } else {
            NavigationView {
                catViewStack()
            }
            .environmentObject(security)
            .onAppear(perform: freshCats)
            .onDisappear(perform: freshCats)
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                
                DispatchQueue.main.async() {
                    security.lockScreen = true
                }
            
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    saveItems()
                }
            }
        }
    }
}

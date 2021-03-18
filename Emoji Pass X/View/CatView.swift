//
//  CatView.swift
//  Emoji Pass X
//
//  Created by StarPlayrX on 2/27/21.
//
import SwiftUI
import CoreData
import AuthenticationServices

class Security: ObservableObject {
    @Published var lockScreen = true
    @Published var signOn = true
    @Published var cloudDebug = false
    @Published var isSimulator = false
    @Published var checkForSim = true
    @Published var catLock = true
    @Published var isValid = false
    @Published var isDeleteListViewValid = false
    @Published var isEditing = false
    @Published var isCatViewSaved = false
    @Published var isListItemViewSaved = false

}

struct CatView: View {
    @State private var showingAlert = false
    @Environment(\.colorScheme) var colorScheme

    @StateObject fileprivate var security = Security()
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ListItem.getFetchRequest()) var listItems: FetchedResults<ListItem>
    let name = "Name"
    let emoji = ":)"
    let newCategory = "New Category"
    
    let cat = "🐛"
    let pencil = "✏️"
    let star = "⭐️"
    let magnifier = "🔍"
    
    let settingsMsg = "We're sorry. It doesn't appear your device is logged into iCloud. In Settings, please log into your iCloud account and try again."
    let settingsMsgiPad = "We're sorry. It doesn't appear your device is logged into iCloud.\r\nIn Settings, please log into your iCloud account and try again."

    let stars = "Stars"
    let everything = "Everything"
    let uuidCount = 36
    
    @State var searchText: String = ""
    
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
    
    //MARK: catViewStack
    func catViewStack() -> some View {
        return Group {
            
            let category = listItems.filter( { $0.isParent == true })
            
            List {
                
                searchStack()
                
                ForEach( getList(category), id: \.self ) { item in
                    
                    
                    if !security.catLock {
                        
                        NavigationLink(destination: CatEditView(listItem: item)) {
                            
                            if !item.name.isEmpty {
                                Text("\(pencil) \(item.name)")
                                    .padding(.trailing, 18)
                                    .padding(.leading, iPhoneXCell())
                                    .font(.title)
                            } else {
                                Text("\(pencil) \(newCategory)")
                                    .padding(.trailing, 18)
                                    .padding(.leading, iPhoneXCell())
                                    .font(.title)
                            }
                           
                        }
                        .overlay (
                            HStack {
                                Spacer()
                                Text("\(getCount(listItems,item))")
                                    .padding(.trailing, 18)
                            }
                        )
                        
                    } else if item.name == newCategory || item.name.isEmpty  {
                        
                        //let gc = getCount(a: listItems, b: item)
                        NavigationLink(destination: CatEditView(listItem: item)) {
                            Text("\(cat) \(newCategory)")
                                .padding(.trailing, 18)
                                .padding(.leading, iPhoneXCell())
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
                                .padding(.leading, iPhoneXCell())
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
                .onDelete(perform: security.isEditing ? deleteItem : nil )
                .onMove(perform: moveItem)
                .padding(.trailing, 0)
                .frame(height:40)
            }
            
            .padding(.leading, iPhoneXLeading())
            .listStyle(PlainListStyle())

        }
        .environment(\.editMode, .constant(security.isEditing ? EditMode.active : EditMode.inactive)).animation(security.isEditing ? .easeInOut : .none)
        .navigationBarTitle("Categories", displayMode: .inline)
        .toolbar {
            
            
                ToolbarItemGroup(placement: .bottomBar) {
                    
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        Spacer()
                        Button(action: { saveItems();security.isEditing = false;security.catLock = true;security.isCatViewSaved = true})
                        {
                            Text("Save")
                        }
                        Spacer()
                }
            }
            
            
          
            
            
            ToolbarItemGroup(placement: .navigationBarLeading) {
            
                Button(action: {  security.isEditing = !security.isEditing  })
                {
                    if security.isEditing  {
                        Image(systemName: "hammer")
                    } else {
                        Image(systemName: "hammer.fill")
                    }
                }

            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: { security.catLock = !security.catLock })
                {
                    if !security.catLock {
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
    
    //MARK: See if iCloud is available
    func checkForCloudKit() -> Bool {
        FileManager.default.ubiquityIdentityToken != nil ? true : false
    }

    //MARK: lockStack
    func lockStack() -> some View {
        return VStack {
            
            Text("Emoji Pass X").font(.largeTitle).minimumScaleFactor(0.1).padding(.top, 100)

            HStack {
                
                Image("Emoji Pass X_logo4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 230.0,height:230)
                    .background(Color.clear)
            }
            
            Text("© 2021 Todd Bruss").font(.callout).minimumScaleFactor(0.1).padding(.top, 10)
            
          
            if security.signOn && !security.isSimulator {
                SignInWithAppleButton(.continue,
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
                    .padding(.horizontal, 50)
                    .padding(.vertical, 100)
                    .frame(maxWidth: 375,  maxHeight: 265, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color(UIColor.systemBackground))
                    .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
            } else {
                
                if security.isSimulator {
                    Button("Continue with Simulator") {
                        security.lockScreen = false
                    }
                        .padding(.horizontal, 50)
                        .padding(.vertical, 100)
                        .frame(maxWidth: 375,  maxHeight: 266, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                } else {
                    Button("Continue with Device") {
                        security.lockScreen = false
                    }
                        .padding(.horizontal, 50)
                        .padding(.vertical, 100)
                        .frame(maxWidth: 375,  maxHeight: 266, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            }
        }
        
        .background(Color(UIColor.systemBackground))
    }

    
    private func openIcloud() {
        let settingsCloudKitURL = URL(string: "App-Prefs:root=CASTLE")
        if let url = settingsCloudKitURL, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
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
        
        saveItems()

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
           
        }
        
        if let source = indexSet.first, let listItem = Optional(cf[source]) {
            var duplicateStars = false
            var duplicateEverything = false
            
            let starLite = listItems.filter( { $0.isParent == true && $0.uuidString == stars }).count
   
            if starLite > 1 {
                duplicateStars = true
            }
            
            let everythingBagel = listItems.filter( { $0.isParent == true && $0.uuidString == everything }).count

            if everythingBagel > 1 {
                duplicateEverything = true
            }
            
            let gc = getCount(listItems, listItem)
            
            if gc.isEmpty && listItem.uuidString.count == uuidCount {
                managedObjectContext.delete(listItem)
            } else if listItem.uuidString == stars && duplicateStars  {
                managedObjectContext.delete(listItem)
            } else if listItem.uuidString == everything && duplicateEverything {
                managedObjectContext.delete(listItem)
            } else {
                generator.notificationOccurred(.error)
                security.isValid = true
            }
            
            saveItems()

        }
        
    }
    
    func showLockScreen() {
        security.lockScreen = true
        
        #if targetEnvironment(simulator)
            security.isSimulator = true
        #else
            security.isSimulator = false
        #endif
    }
    
    
    func freshCats() {
            DispatchQueue.main.async() {
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
        
            _ = ListItem.getFetchRequest()
        

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
        if security.lockScreen  {
            lockStack()
            .onAppear(perform: showLockScreen)
        } else {
            ZStack {
                
                NavigationView {
                    catViewStack()
                }
                
            }
            .alert(isPresented: $security.isValid, content: {
                        Alert(title: Text("We're sorry."),
                              message: Text("This category cannot be deleted."),
                              dismissButton: .default(Text("OK")) { security.isValid = false })
                    })
            .alert(isPresented: $security.isCatViewSaved, content: {
                        Alert(title: Text("Save"),
                              message: Text("Changes have been saved."),
                              dismissButton: .default(Text("OK")) { security.isCatViewSaved = false })
                    })
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
        }
    }
}

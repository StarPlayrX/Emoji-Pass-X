//
//  CatView.swift
//  Emoji Pass X
//
//  Created by StarPlayrX on 2/27/21.
//
import SwiftUI
import CoreData
import AuthenticationServices

private class Security: ObservableObject {
    @Published var lockScreen = true
    @Published var cloudDebug = true

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
                        
                    } else if item.name == newCategory  {
                        
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
                .onDelete(perform: deleteItem)
                .onMove(perform: moveItem)
                .padding(.trailing, 0)
                .frame(height:40)
            }
            .padding(.leading, iPhoneXLeading())
            .listStyle(PlainListStyle())
        }
        .navigationBarTitle("Categories", displayMode: .inline)
        .toolbar {
            
            ToolbarItemGroup(placement: .navigationBarLeading) {
                
                Button(action: { catLock = !catLock })
                {
                    if !catLock {
                        Image(systemName: "lock.open")
                    } else {
                        Image(systemName: "lock.fill")
                    }
                }
                
                
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                EditButton()

                
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
            
            if let destination = URL(string: "https://starplayrx.com") {
                Link("StarPlayrX.com", destination: destination ).font(.callout).minimumScaleFactor(0.1).padding(.top, 5)
            }
            
            
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
                .background(Color(UIColor.systemBackground))
            
        }
        .signInWithAppleButtonStyle(colorScheme == .dark ? .black : .white)
        .background(Color(UIColor.systemBackground))
    }

    func cloudStack() -> some View {
        return VStack {
            
            Spacer()

            Text("Emoji Pass X").font(.largeTitle).minimumScaleFactor(0.8).padding(.top, 10)

            HStack {
                
                Image("Emoji Pass X_logo4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 230.0,height:230)
                    .background(Color.clear)
            }
            
            Text("© 2021 Todd Bruss").font(.callout).minimumScaleFactor(0.8).padding(.top, 10)
            
            if let destination = URL(string: "https://starplayrx.com") {
                Link("StarPlayrX.com", destination: destination ).font(.callout).minimumScaleFactor(0.1).padding(.top, 5)
            }
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                Text(settingsMsgiPad).foregroundColor(Color.red).font(.body).minimumScaleFactor(0.5).multilineTextAlignment(.center)
                    .padding(15)
                
            } else {
                Text(settingsMsg).foregroundColor(Color.red).font(.body).minimumScaleFactor(0.5).multilineTextAlignment(.center)
                    .padding(15)
            }
            
            Button("Try again") {
                
                showingAlert = false

                let icloud = checkForCloudKit()
                
                if icloud {
                    _ = ListItem.getFetchRequest()
                    
                    checkForSimulator()
                    showingAlert = false
                } else {
                    showingAlert = true
                }
            }.alert(isPresented: $showingAlert) {
                
                #if targetEnvironment(simulator)
                    return Alert(title: Text("iCloud Sign On Error"), message: Text(settingsMsg),
                          dismissButton: .default(Text("Ok")))
                #else
                    return Alert(title: Text("iCloud Sign On Error"), message: Text(settingsMsg),
                                 primaryButton: .cancel(Text("Open Settings")) { openIcloud() },
                                 secondaryButton: .default(Text("Ok")))
                #endif
                
            }.padding(10)
                
            Spacer()
         
        }
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
            return
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
            }
        }
        
        saveItems()
    }
    
    func checkForSimulator() {
        #if targetEnvironment(simulator)
            DispatchQueue.main.async() {
                security.lockScreen = false
            }
        #else
            DispatchQueue.main.async() {
                security.lockScreen = true
            }
        #endif
    }
    
    
    func freshCats() {        
        #if !targetEnvironment(simulator)
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
        #else
            _ = ListItem.getFetchRequest()
        #endif
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
        if security.cloudDebug {
            lockStack()
        } else if security.lockScreen && checkForCloudKit() {
            lockStack()
            .onAppear(perform: checkForSimulator)

        } else if !security.lockScreen && checkForCloudKit() {
            NavigationView {
                catViewStack()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(security)
            .onAppear(perform: freshCats)
            .onDisappear(perform: freshCats)
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                
                checkForSimulator()
            
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    saveItems()
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                DispatchQueue.main.async() {
                    freshCats()
                }
            }
        } else if !checkForCloudKit() {
            cloudStack()
        }
    }
}

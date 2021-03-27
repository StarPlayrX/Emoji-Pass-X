//
//  catStack.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
//

import SwiftUI


//MARK: catViewStack
extension CatView {
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
                .alert(isPresented: $security.isValid, content: {
                    Alert(title: Text("We're sorry."),
                          message: Text("This category cannot be deleted."),
                          dismissButton: .default(Text("OK")) { security.isValid = false })
                })
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
                        .alert(isPresented: $security.isCatViewSaved, content: {
                                    Alert(title: Text("Save"),
                                          message: Text("Changes have been saved."),
                                          dismissButton: .default(Text("OK")) { security.isCatViewSaved = false })
                                })
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
}

//
//  catViewList.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/24/21.
//
import SwiftUI

extension CatView {
    func catViewList() -> some View {
        List {
            let category = listItems.filter({ $0.isParent == true })
            
            catViewSsearchBar()
            
            ForEach(getList(category), id: \.self) { item in
                if !security.catLock {
                    NavigationLink(destination: CatEditView(listItem: item)) {
                        
                        if !item.name.isEmpty {
                            Text("\(pencil)\(item.emoji) \(item.name)")
                                .padding(.trailing, 18)
                                .padding(.leading, Device().iPhoneXCell())
                                .font(.title)
                        } else {
                            Text("\(pencil)\(item.emoji) \(newCategory)")
                                .padding(.trailing, 18)
                                .padding(.leading, Device().iPhoneXCell())
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
                    NavigationLink(destination: CatEditView(listItem: item)) {
                        Text("\(cat) \(newCategory)")
                            .padding(.trailing, 18)
                            .padding(.leading, Device().iPhoneXCell())
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
                            .padding(.leading, Device().iPhoneXCell())
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
        .padding(.leading, Device().iPhoneXLeading())
        .listStyle(PlainListStyle())
    }
}

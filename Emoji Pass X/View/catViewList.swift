//
//  catViewList.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/24/21.
//
import SwiftUI

extension CatView {
    func catViewList(detailListItems: FetchedResults<ListItem>) -> some View {
        List {
            let category = listItems.filter({ $0.isParent == true })
            
            catViewSearchBar()
            
            ForEach(catStruct.getList(category, searchText), id: \.self) { item in
                if !security.catLock {
                    NavigationLink(destination: CatEditView(listItem: item)) {
                        
                        if !item.name.isEmpty {
                            Text("\(item.emoji) \(item.name)")

                                .padding(.trailing, 18)
                                .padding(.leading, Device().iPhoneXCell())
                                .font(.title)
                        } else {
                            Text("\(item.emoji) \(CategoryStrings.newCategory.rawValue)")
                                .padding(.trailing, 18)
                                .padding(.leading, Device().iPhoneXCell())
                                .font(.title)
                        }
                    }
                    .overlay (
                        HStack {
                            Spacer()
                            Text("\(catStruct.getCount(listItems,item))")
                                .foregroundColor(.orange)
                                .padding(.trailing, 18)
                        }
                    )
                } else if item.name == CategoryStrings.newCategory.rawValue || item.name.isEmpty  {
                    NavigationLink(destination: CatEditView(listItem: item)) {
                        Text("\(CategoryStrings.caterpillar.rawValue) \(CategoryStrings.newCategory.rawValue)")
                            .padding(.trailing, 18)
                            .padding(.leading, Device().iPhoneXCell())
                            .font(.title)
                    }
                    .overlay (
                        HStack {
                            Spacer()
                            Text("\(catStruct.getCount(listItems,item))")
                                .padding(.trailing, 18)
                        }
                    )
                } else {
                    //let gc = getCount(a: listItems, b: item)
                    NavigationLink(destination: ListView(catItem: item, detailListItems: detailListItems)) {
                        Text("\(item.emoji) \(item.name)")
                            .padding(.trailing, 18)
                            .padding(.leading, Device().iPhoneXCell())
                            .font(.title)
                    }
                    .isDetailLink(false)
                    .overlay (
                        HStack {
                            Spacer()
                            Text("\(catStruct.getCount(listItems,item))")
                                .padding(.trailing, 18)
                        }
                    )
                }
            }
            .onDelete(perform: security.isEditing ? deleteItem : nil )
            .onMove(perform: moveItem)
           // .padding(.trailing, 0)
            .frame(height:40)
        }
        .padding(.leading, Device().iPhoneXLeading())
        .listStyle(PlainListStyle())
    }
}

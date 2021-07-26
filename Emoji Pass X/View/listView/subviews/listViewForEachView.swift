//
//  listViewForEachView.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ListView {
    func listViewForEachView(_ a:  FetchedResults<ListItem>) -> some View {
        
        ForEach(getList(coldFilter(a)) , id: \.self) { item in
            NavigationLink(destination: ItemView(catItem: catItem, listItem: item)) {
                
                if !item.name.isEmpty {
                    Text("\(item.emoji) \(item.name)")
                        .padding(.trailing, 18)
                        .padding(.leading, Device().iPhoneXCell())
                    
                } else {
                    Text("\(item.emoji) \(newRecord)")
                        .padding(.trailing, 18)
                        .padding(.leading, Device().iPhoneXCell())
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
            .onDisappear(perform: saveItems )
            .onAppear(perform: saveItems )     
            .font(.title)
            .listRowBackground(Color(UIColor.systemBackground))
            
        }
        .onDelete(perform: security.isEditing ? deleteItem : nil )
        .onMove(perform: moveItem)
        .padding(.trailing, 0)
        .frame(height:40)
    }  
}

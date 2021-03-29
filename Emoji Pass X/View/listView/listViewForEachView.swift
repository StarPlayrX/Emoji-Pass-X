//
//  listViewForEachView.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
//

import SwiftUI

extension ListView {
    func forEach(_ a:  FetchedResults<ListItem>) -> some View {
        ForEach( getList(coldFilter(a) ) , id: \.self) { item in
            NavigationLink(destination: ItemView(catItem: catItem, listItem: item)) {
                Text("\(item.emoji) \(item.name)")
                    .padding(.trailing, 18)
                    .padding(.leading, iPhoneXCell())

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
        .onDelete(perform: security.isEditing ? deleteItem : nil )
        .onMove(perform: moveItem)
        .alert(isPresented: $security.isDeleteListViewValid, content: {
            Alert(title: Text("We're sorry."),
                  message: Text("This item is locked and cannot be deleted."),
                  dismissButton: .default(Text("OK")) { security.isDeleteListViewValid = false })
        })
        .padding(.trailing, 0)
        .frame(height:40)
    }
}

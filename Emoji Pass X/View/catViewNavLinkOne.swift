//
//  catNavLinkOne.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/22/21.
//

import SwiftUI

extension CatView {
    
    func catViewNavLinkOne(_ item: ListItem) -> some View {
        NavigationLink(destination: CatEditView(listItem: item)) {
            
            if !item.name.isEmpty {
                Text("\(pencil)\(item.emoji) \(item.name)")
                    .padding(.trailing, 18)
                    .padding(.leading, iPhoneXCell())
                    .font(.title)
            } else {
                Text("\(pencil)\(item.emoji) \(newCategory)")
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
    }
}



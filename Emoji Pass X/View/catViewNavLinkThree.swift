//
//  catNavLinkThree.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/22/21.
//

import SwiftUI

extension CatView {
    
    func catViewNavLinkThree(_ item: ListItem) -> some View {
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

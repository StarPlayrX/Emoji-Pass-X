//
//  catNavLinkTwo.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/22/21.
//

import Foundation

import SwiftUI

extension CatView {
    
    func catViewNavLinkTwo(_ item: ListItem) -> some View {
        
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
    }
}

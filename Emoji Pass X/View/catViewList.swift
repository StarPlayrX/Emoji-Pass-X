//
//  catViewList.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/22/21.
//

import SwiftUI

extension CatView {
    func catViewList() -> some View {
        List {
            searchStack()
            
            let category = listItems.filter({ $0.isParent == true })
            
            ForEach(getList(category), id: \.self) { item in
                if !security.catLock {
        
                    catViewNavLinkOne(item)
                    
                } else if item.name == newCategory || item.name.isEmpty  {

                    catViewNavLinkTwo(item)
                    
                } else {
                    
                    catViewNavLinkThree(item)

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
}

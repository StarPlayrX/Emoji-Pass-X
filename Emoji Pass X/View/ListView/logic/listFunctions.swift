//
//  listFunctions.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/27/21.
//

import SwiftUI

extension ListView {
    func canCreate(catItem: ListItem) -> Button<Image>? {
        catItem.uuidString != "Stars" && catItem.uuidString != "Everything" ? New() : nil
    }

    func New() -> Button<Image> {
        Button(action: {listStruct.addItem(catItem, managedObjectContext, detailListItems)}) {Image(systemName: "plus")}
    }

    func moveItem(from source: IndexSet, to destination: Int) {
        listStruct.moveThisItem(source, destination, detailListItems, managedObjectContext, catItem, searchText)
    }

    func deleteItem(indexSet: IndexSet) {
        listStruct.deleteThisItem(indexSet, detailListItems, catItem, managedObjectContext, security, searchText)
    }
}

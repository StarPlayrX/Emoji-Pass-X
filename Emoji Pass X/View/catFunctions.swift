//
//  catFunctions.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/27/21.
//

import SwiftUI

protocol CatViewProtocol {
    func deleteItem(indexSet: IndexSet)
    func moveItem(from source: IndexSet, to destination: Int)
}

extension CatView: CatViewProtocol {

    // indexSet is inferred
    func deleteItem(indexSet: IndexSet) {
        catStruct.deleteThisItem(
            indexSet,
            listItems: listItems,
            managedObjectContext: managedObjectContext,
            security: security,
            searchText: searchText
        )
    }

    func moveItem(from source: IndexSet, to destination: Int) {
        catStruct.moveThisItem(
            source: source,
            destination: destination,
            listItems: listItems,
            managedObjectContext: managedObjectContext,
            security: security,
            searchText: searchText)
    }
}

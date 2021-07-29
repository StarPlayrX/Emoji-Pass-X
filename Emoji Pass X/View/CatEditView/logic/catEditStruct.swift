//
//  catEditViewStruct.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI
import CoreData

struct CatEditStruct {
    func save(_ listItem: ListItem,_ managedObjectContext: NSManagedObjectContext,_ selectedTemplate: Int ) {
        listItem.templateId = selectedTemplate

        if listItem.name.isEmpty       {listItem.name       = CategoryStrings.newCategory.rawValue}
        if listItem.emoji.isEmpty      {listItem.emoji      = CategoryStrings.caterpillar.rawValue}
        if listItem.uuidString.isEmpty {listItem.uuidString = UUID().uuidString}

        DispatchQueue.main.async() {
            HideKeys().hideKeyboard()
            if managedObjectContext.hasChanges {try? managedObjectContext.save()}
        }
    }

    func createNewCategory(_ listItem: ListItem,_ security: Security) {
        if listItem.uuidString.isEmpty { listItem.uuidString = UUID().uuidString }
        let newCategory = "New Category"
        _ = (listItem.name == newCategory || listItem.name.isEmpty) ?
            (listItem.name = String(), security.isCategoryNew = true) :
            (listItem.name = listItem.name, security.isCategoryNew = false)
    }

    func Stars(_ listItem: ListItem,_ security: Security) {
        listItem.name = "All Stars"
        listItem.uuidString = CategoryType.stars.rawValue
        listItem.emoji = "⭐️"
        listItem.desc = "A store for all my favorites."
        security.previousEmoji = listItem.emoji
    }

    func Everything(_ listItem: ListItem,_ security: Security) {
        listItem.name = "Flashlight"
        listItem.uuidString = CategoryType.everything.rawValue 
        listItem.emoji = "🔦"
        listItem.desc = "A store for all my records."
        security.previousEmoji = listItem.emoji
    }
}

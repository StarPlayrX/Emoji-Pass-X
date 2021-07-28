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
        let newRecord = "New Category"
        let catepillar = "🐛"

        if listItem.name.isEmpty       {listItem.name       = newRecord}
        if listItem.emoji.isEmpty      {listItem.emoji      = catepillar}
        if listItem.uuidString.isEmpty {listItem.uuidString = UUID().uuidString}

        DispatchQueue.main.async() {
            hideKeyboard()
            if managedObjectContext.hasChanges { try? managedObjectContext.save() }
        }
    }

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
        listItem.uuidString = "Stars"
        listItem.emoji = "⭐️"
        listItem.desc = "A store for all my favorites."
        security.previousEmoji = listItem.emoji
    }

    func Everything(_ listItem: ListItem,_ security: Security) {
        listItem.name = "Flashlight"
        listItem.uuidString = "Everything"
        listItem.emoji = "🔦"
        listItem.desc = "A store for all my records."
        security.previousEmoji = listItem.emoji
    }
}

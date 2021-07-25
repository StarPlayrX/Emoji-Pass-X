//
//  catEditViewFunctions.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension CatEditView {
    
    // Rolls back Emojis to 1 character
    func limitText(_ charLimit : Int = 1 ) {
        if listItem.emoji.count > charLimit {
            let usePrefix = prevEmoji == listItem.emoji.suffix(charLimit)
            listItem.emoji = String( usePrefix ? listItem.emoji.prefix(charLimit) : listItem.emoji.suffix(charLimit) )
        }
        prevEmoji = listItem.emoji
    }
    
    func copyDesc() {
        pasteboard.string = listItem.desc
    }
    
    func save() {
        listItem.templateId = selectedTemplate
        if listItem.name.isEmpty       { listItem.name       = newRecord }
        if listItem.emoji.isEmpty      { listItem.emoji      = pencil }
        if listItem.uuidString.isEmpty { listItem.uuidString = UUID().uuidString }
        
        DispatchQueue.main.async() {
            hideKeyboard()
            if managedObjectContext.hasChanges { try? managedObjectContext.save() }
        }
    }
    
    func clearNewText() {
        if listItem.uuidString.isEmpty { listItem.uuidString = UUID().uuidString }
        _ = (listItem.name == newRecord || listItem.name.isEmpty) ?
            (listItem.name = String(), security.isCategoryNew = true) :
            (listItem.name = listItem.name, security.isCategoryNew = false)
    }
    
    func Stars() {
        listItem.name = "All Stars"
        listItem.uuidString = "Stars"
        listItem.emoji = "⭐️"
        listItem.desc = "A store for all my favorites."
        security.previousEmoji = listItem.emoji
    }
    
    func Everything() {
        listItem.name = "Flashlight"
        listItem.uuidString = "Everything"
        listItem.emoji = "🔦"
        listItem.desc = "A store for all my records."
        security.previousEmoji = listItem.emoji
    }
}

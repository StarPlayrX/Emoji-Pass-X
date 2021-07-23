//
//  catEditViewFunctions.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension CatEditView {
    //MARK: Function to keep text length in limits
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
        listItem.name.isEmpty       ? listItem.name       = newRecord         : ()
        listItem.emoji.isEmpty      ? listItem.emoji      = pencil            : ()
        listItem.uuidString.isEmpty ? listItem.uuidString = UUID().uuidString : ()
        
        DispatchQueue.main.async() {
            hideKeyboard()
            managedObjectContext.hasChanges ? try? managedObjectContext.save() : ()
        }
    }
    
    func clearNewText() {
        listItem.uuidString.isEmpty ? listItem.uuidString = UUID().uuidString : ()
        _ = (listItem.name == newRecord || listItem.name.isEmpty) ?
            (listItem.name = "", security.isCategoryNew = true) :
            (listItem.name = listItem.name, security.isCategoryNew = false)
    }
}

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
        
        if listItem.emoji.count == charLimit  {
            
            prevEmoji = listItem.emoji
        
        } else if listItem.emoji.count > charLimit {
            
            let usePrefix = prevEmoji == listItem.emoji.suffix(charLimit) ? true : false
            
            //MARK: You can do alot with teranies. Notice how the String type is defined outside the terany
            listItem.emoji = String( usePrefix ? listItem.emoji.prefix(charLimit) : listItem.emoji.suffix(charLimit) )
            
            prevEmoji = listItem.emoji
        } else {
            prevEmoji = listItem.emoji

        }
    }
    
    
    
    func copyDesc() {
        pasteboard.string = listItem.desc
    }
    
    func save() {
        
        //epoche date used to break cache and force a save
        //listItem.dateString = String(Int(Date().timeIntervalSinceReferenceDate))
        
        if  listItem.name.isEmpty {
            listItem.name = newRecord
        }
        
        if listItem.emoji.isEmpty {
            listItem.emoji  = pencil
        }
    
        listItem.templateId = selectedTemplate
                
        if listItem.uuidString.isEmpty {
            listItem.uuidString = UUID().uuidString
        }
        
        DispatchQueue.main.async() {
            
            hideKeyboard()

            // do something
            if managedObjectContext.hasChanges {
                try? managedObjectContext.save()
            }
            
          //  security.isCatEditViewSaved = false
        }
        
    }
    
    func clearNewText() {
        
        if listItem.uuidString.isEmpty {
            listItem.uuidString = UUID().uuidString
        }
        
        //New Item detected, so we clear this out (otherwise fill it in!)
        if listItem.name == newRecord || listItem.name.isEmpty {
            listItem.name = ""
            security.isCategoryNew = true
        } else {
            security.isCategoryNew = false
        }
        

    }

}

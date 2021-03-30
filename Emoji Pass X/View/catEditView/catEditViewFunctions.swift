//
//  catEditViewFunctions.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
//

import SwiftUI

extension CatEditView {
        
    //MARK: Function to keep text length in limits
    func limitText(_ str: String ) {
        
        let limiter = 1
        
        var usePrefix = true
        
        if str.count == limiter && security.previousEmoji != str {
            security.previousEmoji = str
        }
        
        if security.previousEmoji.count == limiter {
            if security.previousEmoji == listItem.emoji.prefix(limiter) {
                usePrefix = false
            } else if security.previousEmoji == listItem.emoji.suffix(limiter)  {
               usePrefix = true
            }
        }
        
      
        if listItem.emoji.count > limiter {
            if usePrefix {
                listItem.emoji = String(listItem.emoji.prefix(limiter))
            } else {
                listItem.emoji = String(listItem.emoji.suffix(limiter))
            }
            
            
            if security.previousEmoji.count == limiter {
                security.previousEmoji = listItem.emoji
            }
        }
    }
    
    
    func copyDesc() {
        pasteboard.string = listItem.desc
    }
    
    func save() {
        
        //epoche date used to break cache and force a save
        listItem.dateString = String(Int(Date().timeIntervalSinceReferenceDate))
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
            // do something
            if managedObjectContext.hasChanges {
                try? managedObjectContext.save()
            }
            
            hideKeyboard()
        }
    }
    
    func clearNewText() {
        
        if listItem.uuidString.isEmpty {
            listItem.uuidString = UUID().uuidString
        }
        
        //New Item detected, so we clear this out (otherwise fill it in!)
        if listItem.name == newRecord {
            listItem.name = ""
        }
        
        if !listItem.emoji.isEmpty && listItem.emoji.count == 1 {
            security.previousEmoji = listItem.emoji
        }
    }

}

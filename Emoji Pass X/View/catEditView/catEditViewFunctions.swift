//
//  catEditViewFunctions.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
//

import SwiftUI

extension CatEditView {
    
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

        //New Item detected, so we clear this out (otherwise fill it in!)
        if listItem.emoji == pencil && listItem.name == newRecord {
            listItem.name  = ""
            listItem.emoji = ""
        }
    }

}

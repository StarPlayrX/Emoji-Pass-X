//
//  saveFunction.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ItemView {
    
    func save(shouldHideKeyboard: Bool = false, _ record: Record) {
    
        let krypt = Krypto()
        
        if shouldHideKeyboard {hideKeyboard()}
        
        // https://newbedev.com/loop-through-swift-struct-to-get-keys-and-values
        let mirror = Mirror(reflecting: record)
        
        // save our encrypted data
        for child in mirror.children  {
            if let value = child.value as? String, !value.isEmpty, let key = child.label {
                
                // Encrypts 16 items and saves them via listItem 
                let enKrypt = krypt.encrypt(string: value, key: privateKey.recordKey, encoding: .utf8)
                listItem.setValue(enKrypt, forKey: key)
            }
        }
        
        DispatchQueue.main.async() {
            if managedObjectContext.hasChanges {try? managedObjectContext.save()}
            listItem.name.isEmpty  ? (listItem.name  = newRecord) : (listItem.name  = listItem.name)
            listItem.emoji.isEmpty ? (listItem.emoji = pencil)    : (listItem.emoji = listItem.emoji)
        }
    }
}

//
//  clearNewTextFunction.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//
import SwiftUI

extension ItemView {
    
    func load(rec: Record) {
        
        record = rec
        
        let krypt = Krypto()
        
        privateKey.parentKey = krypt.emojiParentKey()
        
        //New Item detected, so we clear this out (otherwise fill it in!)
        if (listItem.name == newRecord) {
            listItem.templateId = catItem.templateId
            listItem.name = String()
        }
        
        if listItem.uuidString.isEmpty {listItem.uuidString = catItem.uuidString}
        
        //MARK: - listItem.id = our Encrypted Key
        /// Each Record has its own Encrpytion Key and get's encrypted with our Private Key
        if listItem.id.isEmpty {
            let emojiKey         = krypt.emojiRecordKey()
            let emojiData        = krypt.createEncryptedKey(emojiKey: emojiKey, key: privateKey.parentKey)
            privateKey.recordStr = krypt.decryptEncryptedKey(emojiData: emojiData, key: privateKey.parentKey)
            listItem.id          = emojiData
        } else {
            privateKey.recordStr = krypt.decryptEncryptedKey(emojiData: listItem.id, key: privateKey.parentKey)
            
            if privateKey.recordStr.isEmpty || privateKey.recordStr.count != 8 {
                let emojiKey  = krypt.emojiRecordKey()
                let emojiData = krypt.createEncryptedKey(emojiKey: emojiKey, key: privateKey.parentKey)
                listItem.id   = emojiData
            }
        }
        
        // Decrypted Record Key
        privateKey.recordKey = krypt.decryptEncryptedKey(emojiData: listItem.id, key: privateKey.parentKey).data
        
        // https://newbedev.com/loop-through-swift-struct-to-get-keys-and-values
        
        // Load our decrypted data
        let mirror = Mirror(reflecting: record)
        
        for child in mirror.children  {
            if let key = child.label, let value = listItem.value(forKey: key) as? Data, !value.isEmpty {
                
                // Decrypts 16 items and assigns them to record
                let deKrypt = krypt.decrypt(data: value, key: privateKey.recordKey, encoding: .utf8)
                record[key] = deKrypt
            }
        }
    }
}

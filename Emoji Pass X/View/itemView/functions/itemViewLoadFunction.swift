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
        
        privateKey.parentKey = emojiParentKey()
        
        //New Item detected, so we clear this out (otherwise fill it in!)
        if (listItem.name == newRecord) {
            listItem.templateId = catItem.templateId
            listItem.name = String()
        }
        
        if listItem.uuidString.isEmpty {listItem.uuidString = catItem.uuidString}
        
        //MARK: - listItem.id = our Encrypted Key
        /// Each Record has its own Encrpytion Key and get's encrypted with our Private Key
        if listItem.id.isEmpty {
            let emojiKey         = emojiRecordKey()
            let emojiData        = createEncryptedKey(emojiKey: emojiKey)
            privateKey.recordStr = decryptEncryptedKey(emojiData: emojiData)
            listItem.id          = emojiData
        } else {
            privateKey.recordStr = decryptEncryptedKey(emojiData: listItem.id)
            
            if privateKey.recordStr.isEmpty || privateKey.recordStr.count != 8 {
                let emojiKey  = emojiRecordKey()
                let emojiData = createEncryptedKey(emojiKey: emojiKey)
                listItem.id   = emojiData
            }
        }
        
        // Decrypted Record Key
        privateKey.recordKey = decryptEncryptedKey(emojiData: listItem.id).data
        
        // https://newbedev.com/loop-through-swift-struct-to-get-keys-and-values
        
        // Load our decrypted data
        let mirror = Mirror(reflecting: record)
        
        for child in mirror.children  {
            if let key = child.label, let value = listItem.value(forKey: key) as? Data, !value.isEmpty {
                let deKrypt = krypt.decrypt(data: value, key: privateKey.recordKey, encoding: .utf8)
                record[key] = deKrypt
            }
        }
    }
}

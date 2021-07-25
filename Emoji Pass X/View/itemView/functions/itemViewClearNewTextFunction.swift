//
//  clearNewTextFunction.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ItemView {
    
    func clearNewText() {
        let krypt = Krypto()
        
        privateKey.parentKey = emojiParentKey()
        
        //New Item detected, so we clear this out (otherwise fill it in!)
        if (listItem.name == newRecord) {
            listItem.templateId = catItem.templateId
            listItem.name = String()
        }
        
        if listItem.uuidString.isEmpty { listItem.uuidString = catItem.uuidString }
        
        //MARK: Transition to new way
        if listItem.id.isEmpty {
            let emojiKey    = emojiRecordKey()
            let emojiData   = createEncryptedKey(emojiKey: emojiKey)
            privateKey.recordStr = decryptEncryptedKey(emojiData: emojiData)
            listItem.id  = emojiData
        } else {
            privateKey.recordStr = decryptEncryptedKey(emojiData: listItem.id)
            
            if privateKey.recordStr.isEmpty || privateKey.recordStr.count != 8 {
                let emojiKey  = emojiRecordKey()
                let emojiData = createEncryptedKey(emojiKey: emojiKey)
                listItem.id   = emojiData
            }
        }
        
        // Todo create a loop for this
        // https://newbedev.com/loop-through-swift-struct-to-get-keys-and-values
        
        //decrypted Key
        privateKey.recordKey = decryptEncryptedKey(emojiData: listItem.id).data
        
        pUsername     = krypt.decrypt(data: listItem.pUsername,     key: privateKey.recordKey, encoding: .utf8)
        pPassword     = krypt.decrypt(data: listItem.pPassword,     key: privateKey.recordKey, encoding: .utf8)
        pWebsite      = krypt.decrypt(data: listItem.pWebsite,      key: privateKey.recordKey, encoding: .utf8)
        pPhone        = krypt.decrypt(data: listItem.pPhone,        key: privateKey.recordKey, encoding: .utf8)
        pPin          = krypt.decrypt(data: listItem.pPin,          key: privateKey.recordKey, encoding: .utf8)
        pNotes        = krypt.decrypt(data: listItem.pNotes,        key: privateKey.recordKey, encoding: .utf8)

        cBankname     = krypt.decrypt(data: listItem.cBankname,     key: privateKey.recordKey, encoding: .utf8)
        cCardnumber   = krypt.decrypt(data: listItem.cCardnumber,   key: privateKey.recordKey, encoding: .utf8)
        cFullname     = krypt.decrypt(data: listItem.cFullname,     key: privateKey.recordKey, encoding: .utf8)
        cCvc          = krypt.decrypt(data: listItem.cCvc,          key: privateKey.recordKey, encoding: .utf8)
        cExpdate      = krypt.decrypt(data: listItem.cExpdate,      key: privateKey.recordKey, encoding: .utf8)
        cNotes        = krypt.decrypt(data: listItem.cNotes,        key: privateKey.recordKey, encoding: .utf8)

        kSoftwarepkg  = krypt.decrypt(data: listItem.kSoftwarepkg,  key: privateKey.recordKey, encoding: .utf8)
        kLicensekey   = krypt.decrypt(data: listItem.kLicensekey,   key: privateKey.recordKey, encoding: .utf8)
        kEmailaddress = krypt.decrypt(data: listItem.kEmailaddress, key: privateKey.recordKey, encoding: .utf8)
        kWebaddress   = krypt.decrypt(data: listItem.kWebaddress,   key: privateKey.recordKey, encoding: .utf8)
        kSeats        = krypt.decrypt(data: listItem.kSeats,        key: privateKey.recordKey, encoding: .utf8)
        kNotes        = krypt.decrypt(data: listItem.kNotes,        key: privateKey.recordKey, encoding: .utf8)
    }
}

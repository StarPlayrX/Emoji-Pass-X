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
            listItem.name = ""
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
        
        //decrypted Key
        privateKey.recordKey = decryptEncryptedKey(emojiData: listItem.id).data
        
        pUsername     = krypt.decryptData(data: listItem.pUsername, key: privateKey.recordKey)
        pPassword     = krypt.decryptData(data: listItem.pPassword, key: privateKey.recordKey)
        pWebsite      = krypt.decryptData(data: listItem.pWebsite, key: privateKey.recordKey)
        pPhone        = krypt.decryptData(data: listItem.pPhone, key: privateKey.recordKey)
        pPin          = krypt.decryptData(data: listItem.pPin, key: privateKey.recordKey)
        pNotes        = krypt.decryptData(data: listItem.pNotes, key: privateKey.recordKey)

        cBankname     = krypt.decryptData(data: listItem.cBankname, key: privateKey.recordKey)
        cCardnumber   = krypt.decryptData(data: listItem.cCardnumber, key: privateKey.recordKey)
        cFullname     = krypt.decryptData(data: listItem.cFullname, key: privateKey.recordKey)
        cCvc          = krypt.decryptData(data: listItem.cCvc, key: privateKey.recordKey)
        cExpdate      = krypt.decryptData(data: listItem.cExpdate, key: privateKey.recordKey)
        cNotes        = krypt.decryptData(data: listItem.cNotes, key: privateKey.recordKey)

        kSoftwarepkg  = krypt.decryptData(data: listItem.kSoftwarepkg, key: privateKey.recordKey)
        kLicensekey   = krypt.decryptData(data: listItem.kLicensekey, key: privateKey.recordKey)
        kEmailaddress = krypt.decryptData(data: listItem.kEmailaddress, key: privateKey.recordKey)
        kWebaddress   = krypt.decryptData(data: listItem.kWebaddress, key: privateKey.recordKey)
        kSeats        = krypt.decryptData(data: listItem.kSeats, key: privateKey.recordKey)
        kNotes        = krypt.decryptData(data: listItem.kNotes, key: privateKey.recordKey)
    }
}

//
//  clearNewTextFunction.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
//

import SwiftUI

extension ItemView {
    
    func clearNewText() {
        privateKey.parentKey = emojiParentKey()
        
        //New Item detected, so we clear this out (otherwise fill it in!)
        if ( listItem.emoji == pencil && listItem.name == newRecord) {
            listItem.name  = ""
            listItem.emoji = ""
            listItem.templateId = catItem.templateId
        }
        
        if listItem.uuidString.isEmpty {
            listItem.uuidString = catItem.uuidString
        }
        
        //MARK: Transition to new way
        if listItem.id.isEmpty {
            let emojiKey    = emojiRecordKey()
            let emojiData   = createEncryptedKey(emojiKey: emojiKey)
            privateKey.recordStr = decryptEncryptedKey(emojiData: emojiData)
            listItem.id  = emojiData
        } else {
            privateKey.recordStr = decryptEncryptedKey(emojiData: listItem.id)
            
            if privateKey.recordStr.isEmpty || privateKey.recordStr.count != 8 {
                let emojiKey    = emojiRecordKey()
                let emojiData   = createEncryptedKey(emojiKey: emojiKey)
                
                listItem.id  = emojiData
            }
        }
        
        //decrypted Key
        privateKey.recordKey = decryptEncryptedKey(emojiData: listItem.id).data
        
        pUsername = decryptData(data: listItem.pUsername, key: privateKey.recordKey)
        pPassword = decryptData(data: listItem.pPassword, key: privateKey.recordKey)
        pWebsite  = decryptData(data: listItem.pWebsite, key: privateKey.recordKey)
        pPhone    = decryptData(data: listItem.pPhone, key: privateKey.recordKey)
        pPin      = decryptData(data: listItem.pPin, key: privateKey.recordKey)
        pNotes      = decryptData(data: listItem.pNotes, key: privateKey.recordKey)

        cBankname   = decryptData(data: listItem.cBankname, key: privateKey.recordKey)
        cCardnumber = decryptData(data: listItem.cCardnumber, key: privateKey.recordKey)
        cFullname   = decryptData(data: listItem.cFullname, key: privateKey.recordKey)
        cCvc        = decryptData(data: listItem.cCvc, key: privateKey.recordKey)
        cExpdate    = decryptData(data: listItem.cExpdate, key: privateKey.recordKey)
        cNotes      = decryptData(data: listItem.cNotes, key: privateKey.recordKey)

        kSoftwarepkg  = decryptData(data: listItem.kSoftwarepkg, key: privateKey.recordKey)
        kLicensekey   = decryptData(data: listItem.kLicensekey, key: privateKey.recordKey)
        kEmailaddress = decryptData(data: listItem.kEmailaddress, key: privateKey.recordKey)
        kWebaddress   = decryptData(data: listItem.kWebaddress, key: privateKey.recordKey)
        kSeats        = decryptData(data: listItem.kSeats, key: privateKey.recordKey)
        kNotes        = decryptData(data: listItem.kNotes, key: privateKey.recordKey)

    }
}

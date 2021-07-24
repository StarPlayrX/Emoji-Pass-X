//
//  saveFunction.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ItemView {
    func save(shouldHideKeyboard: Bool = false) {
        
        let krypt = Krypto()
        
        if shouldHideKeyboard {
            hideKeyboard()
        }
        
        //MARK: Save Encrypted Strings
        listItem.pUsername     = krypt.encryptData(string: pUsername,     key: privateKey.recordKey)
        listItem.pPassword     = krypt.encryptData(string: pPassword,     key: privateKey.recordKey)
        listItem.pWebsite      = krypt.encryptData(string: pWebsite,      key: privateKey.recordKey)
        listItem.pPhone        = krypt.encryptData(string: pPhone,        key: privateKey.recordKey)
        listItem.pPin          = krypt.encryptData(string: pPin,          key: privateKey.recordKey)
        listItem.pNotes        = krypt.encryptData(string: pNotes,        key: privateKey.recordKey)

        listItem.cBankname     = krypt.encryptData(string: cBankname,     key: privateKey.recordKey)
        listItem.cCardnumber   = krypt.encryptData(string: cCardnumber,   key: privateKey.recordKey)
        listItem.cFullname     = krypt.encryptData(string: cFullname,     key: privateKey.recordKey)
        listItem.cCvc          = krypt.encryptData(string: cCvc,          key: privateKey.recordKey)
        listItem.cExpdate      = krypt.encryptData(string: cExpdate,      key: privateKey.recordKey)
        listItem.cNotes        = krypt.encryptData(string: cNotes,        key: privateKey.recordKey)

        listItem.kSoftwarepkg  = krypt.encryptData(string: kSoftwarepkg,  key: privateKey.recordKey)
        listItem.kLicensekey   = krypt.encryptData(string: kLicensekey,   key: privateKey.recordKey)
        listItem.kEmailaddress = krypt.encryptData(string: kEmailaddress, key: privateKey.recordKey)
        listItem.kWebaddress   = krypt.encryptData(string: kWebaddress,   key: privateKey.recordKey)
        listItem.kSeats        = krypt.encryptData(string: kSeats,        key: privateKey.recordKey)
        listItem.kNotes        = krypt.encryptData(string: kNotes,        key: privateKey.recordKey)

        DispatchQueue.main.async() {
           
            if managedObjectContext.hasChanges {try? managedObjectContext.save()}
            
            listItem.name.isEmpty  ? (listItem.name  = newRecord) : (listItem.name  = listItem.name)
            listItem.emoji.isEmpty ? (listItem.emoji = pencil)    : (listItem.emoji = listItem.emoji)
        }
    }
}

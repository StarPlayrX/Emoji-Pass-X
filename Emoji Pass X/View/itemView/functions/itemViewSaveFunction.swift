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
        listItem.pUsername     = krypt.encrypt(string: pUsername,     key: privateKey.recordKey, encoding: .utf8)
        listItem.pPassword     = krypt.encrypt(string: pPassword,     key: privateKey.recordKey, encoding: .utf8)
        listItem.pWebsite      = krypt.encrypt(string: pWebsite,      key: privateKey.recordKey, encoding: .utf8)
        listItem.pPhone        = krypt.encrypt(string: pPhone,        key: privateKey.recordKey, encoding: .utf8)
        listItem.pPin          = krypt.encrypt(string: pPin,          key: privateKey.recordKey, encoding: .utf8)
        listItem.pNotes        = krypt.encrypt(string: pNotes,        key: privateKey.recordKey, encoding: .utf8)

        listItem.cBankname     = krypt.encrypt(string: cBankname,     key: privateKey.recordKey, encoding: .utf8)
        listItem.cCardnumber   = krypt.encrypt(string: cCardnumber,   key: privateKey.recordKey, encoding: .utf8)
        listItem.cFullname     = krypt.encrypt(string: cFullname,     key: privateKey.recordKey, encoding: .utf8)
        listItem.cCvc          = krypt.encrypt(string: cCvc,          key: privateKey.recordKey, encoding: .utf8)
        listItem.cExpdate      = krypt.encrypt(string: cExpdate,      key: privateKey.recordKey, encoding: .utf8)
        listItem.cNotes        = krypt.encrypt(string: cNotes,        key: privateKey.recordKey, encoding: .utf8)

        listItem.kSoftwarepkg  = krypt.encrypt(string: kSoftwarepkg,  key: privateKey.recordKey, encoding: .utf8)
        listItem.kLicensekey   = krypt.encrypt(string: kLicensekey,   key: privateKey.recordKey, encoding: .utf8)
        listItem.kEmailaddress = krypt.encrypt(string: kEmailaddress, key: privateKey.recordKey, encoding: .utf8)
        listItem.kWebaddress   = krypt.encrypt(string: kWebaddress,   key: privateKey.recordKey, encoding: .utf8)
        listItem.kSeats        = krypt.encrypt(string: kSeats,        key: privateKey.recordKey, encoding: .utf8)
        listItem.kNotes        = krypt.encrypt(string: kNotes,        key: privateKey.recordKey, encoding: .utf8)

        DispatchQueue.main.async() {
           
            if managedObjectContext.hasChanges {try? managedObjectContext.save()}
            
            listItem.name.isEmpty  ? (listItem.name  = newRecord) : (listItem.name  = listItem.name)
            listItem.emoji.isEmpty ? (listItem.emoji = pencil)    : (listItem.emoji = listItem.emoji)
        }
    }
}

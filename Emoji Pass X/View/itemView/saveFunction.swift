//
//  saveFunction.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
//

import SwiftUI

extension ItemView {
    func save() {
        //epoche date used to break cache and force a save
        //listItem.dateString = String(Int(Date().timeIntervalSinceReferenceDate))
        
        //MARK: Save Encrypted Strings
        listItem.pUsername = encryptData(string: pUsername, key: privateKey.recordKey)
        listItem.pPassword = encryptData(string: pPassword, key: privateKey.recordKey)
        listItem.pWebsite  = encryptData(string: pWebsite, key: privateKey.recordKey)
        listItem.pPhone    = encryptData(string: pPhone, key: privateKey.recordKey)
        listItem.pPin      = encryptData(string: pPin, key: privateKey.recordKey)
        listItem.pNotes      = encryptData(string: pNotes, key: privateKey.recordKey)

        listItem.cBankname   = encryptData(string: cBankname, key: privateKey.recordKey)
        listItem.cCardnumber = encryptData(string: cCardnumber, key: privateKey.recordKey)
        listItem.cFullname   = encryptData(string: cFullname, key: privateKey.recordKey)
        listItem.cCvc        = encryptData(string: cCvc, key: privateKey.recordKey)
        listItem.cExpdate    = encryptData(string: cExpdate, key: privateKey.recordKey)
        listItem.cNotes      = encryptData(string: cNotes, key: privateKey.recordKey)

        listItem.kSoftwarepkg  = encryptData(string: kSoftwarepkg, key: privateKey.recordKey)
        listItem.kLicensekey   = encryptData(string: kLicensekey, key: privateKey.recordKey)
        listItem.kEmailaddress = encryptData(string: kEmailaddress, key: privateKey.recordKey)
        listItem.kWebaddress   = encryptData(string: kWebaddress, key: privateKey.recordKey)
        listItem.kSeats        = encryptData(string: kSeats, key: privateKey.recordKey)
        listItem.kNotes        = encryptData(string: kNotes, key: privateKey.recordKey)

        
        DispatchQueue.main.async() {
           
            hideKeyboard()

            listItem.name.isEmpty ? (listItem.name = newRecord) : (listItem.name = listItem.name)
            listItem.emoji.isEmpty ? (listItem.emoji = pencil) : ( listItem.emoji = listItem.emoji)
            
            if managedObjectContext.hasChanges {
                try? managedObjectContext.save()
            }
        }
    }

}

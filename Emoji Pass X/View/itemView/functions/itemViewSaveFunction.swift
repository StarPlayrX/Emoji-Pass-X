//
//  saveFunction.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

// https://newbedev.com/loop-through-swift-struct-to-get-keys-and-values
import SwiftUI

extension ItemView {
    
    func save(shouldHideKeyboard: Bool = false) {
        
        // MARK: - ToDo: Use this struct within the view
        let record = Record(
            pUsername: pUsername,
            pPassword: pPassword,
            pWebsite: pWebsite,
            pPhone: pPhone,
            pPin: pPin,
            pNotes: pNotes,
            
            cBankname: cBankname,
            cCardnumber: cCardnumber,
            cFullname: cFullname,
            cCvc: cCvc,
            cExpdate: cExpdate,
            cNotes: cNotes,
            
            kSoftwarepkg: kSoftwarepkg,
            kLicensekey: kLicensekey,
            kEmailaddress: kEmailaddress,
            kWebaddress: kWebaddress,
            kSeats: kSeats,
            kNotes: kNotes
        )
        
        let krypt = Krypto()
        
        if shouldHideKeyboard {
            hideKeyboard()
        }
        
        let mirror = Mirror(reflecting: record)
        let key = privateKey.recordKey
        
        for child in mirror.children  {
            if let value = child.value as? String, !value.isEmpty, let key = child.label {
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

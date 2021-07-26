//
//  BindingStruct.swift
//  Emoji Pass X
//
//  Created by Todd Brus on 7/22/21.
//

import SwiftUI

/// This is used on our ItemView's Records / UI
struct ItemViewRecords: Identifiable {
    let labl: String
    var text: Binding<String>
    var copy: String
    var keys: UIKeyboardType
    var cntx: UITextContentType
    var id: String { labl }
}

/// Used to translate from decrypted data to encrypted data
struct Record {
    var pUsername = String()
    var pPassword = String()
    var pWebsite = String()
    var pPhone = String()
    var pPin = String()
    var pNotes = String()
    
    var cBankname = String()
    var cCardnumber = String()
    var cFullname = String()
    var cCvc = String()
    var cExpdate = String()
    var cNotes = String()
    
    var kSoftwarepkg = String()
    var kLicensekey = String()
    var kEmailaddress = String()
    var kWebaddress = String()
    var kSeats = String()
    var kNotes = String()
    
    subscript(key: String) -> String {
        get {
            switch key {
            case "pUsername": return self.pUsername
            case "pPassword": return self.pPassword
            case "pWebsite": return self.pWebsite
            case "pPhone": return self.pPhone
            case "pPin": return self.pPin
            case "pNotes": return self.pNotes
            case "cBankname": return self.cBankname
            case "cCardnumber": return self.cCardnumber
            case "cFullname": return self.cFullname
            case "cCvc": return self.cCvc
            case "cExpdate": return self.cExpdate
            case "cNotes": return self.cNotes
            case "kSoftwarepkg": return self.kSoftwarepkg
            case "kLicensekey": return self.kLicensekey
            case "kEmailaddress": return self.kEmailaddress
            case "kWebaddress": return self.kWebaddress
            case "kSeats": return self.kSeats
            case "kNotes": return self.kNotes
            default: return String()
            }
        }
        set {
            switch key {
            case "pUsername": self.pUsername = newValue
            case "pPassword": self.pPassword = newValue
            case "pWebsite": self.pWebsite = newValue
            case "pPhone": self.pPhone = newValue
            case "pPin": self.pPin = newValue
            case "pNotes": self.pNotes = newValue
                
            case "cBankname": self.cBankname = newValue
            case "cCardnumber": self.cCardnumber = newValue
            case "cFullname": self.cFullname = newValue
            case "cCvc": self.cCvc = newValue
            case "cExpdate": self.cExpdate = newValue
            case "cNotes": self.cNotes = newValue
                
            case "kSoftwarepkg": self.kSoftwarepkg = newValue
            case "kLicensekey": self.kLicensekey = newValue
            case "kEmailaddress": self.kEmailaddress = newValue
            case "kWebaddress": self.kWebaddress = newValue
            case "kSeats": self.kSeats = newValue
            case "kNotes": self.kNotes = newValue
            default: print("set Invalid key")
            }
        }
    }
}


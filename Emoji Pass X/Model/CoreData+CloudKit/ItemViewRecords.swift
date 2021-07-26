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
    var pUsername: String?
    var pPassword: String?
    var pWebsite: String?
    var pPhone: String?
    var pPin: String?
    var pNotes: String?
   
    var cBankname: String?
    var cCardnumber: String?
    var cFullname: String?
    var cCvc: String?
    var cExpdate: String?
    var cNotes: String?
   
    var kSoftwarepkg: String?
    var kLicensekey: String?
    var kEmailaddress: String?
    var kWebaddress: String?
    var kSeats: String?
    var kNotes: String?
}

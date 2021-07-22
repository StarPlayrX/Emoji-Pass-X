//
//  clipboard.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ItemView {
    
    func copyPnotes() {
        pasteboard.string = pNotes
        hideKeyboard()
    }
    
    func copyKnotes() {
        pasteboard.string = kNotes
        hideKeyboard()
    }
    
    func copyCnotes() {
        pasteboard.string = cNotes
        hideKeyboard()
    }
    
    func copyUsername() {
        pasteboard.string = pUsername
        hideKeyboard()
    }
    
    func copyPass() {
        pasteboard.string = pPassword
        hideKeyboard()
    }
    
    func copyWeb() {
        pasteboard.string = pWebsite
        hideKeyboard()
    }
    
    func copyPhone() {
        pasteboard.string = pPhone
        hideKeyboard()
    }
    
    func copyPin() {
        pasteboard.string = pPin
        hideKeyboard()
    }
    
    func copyCard() {
        pasteboard.string = cCardnumber
        hideKeyboard()
    }
    
    func copyExp() {
        pasteboard.string = cExpdate
        hideKeyboard()
    }
    
    func copyFullName() {
        pasteboard.string = cFullname
        hideKeyboard()
    }
    
    func copyCVC() {
        pasteboard.string = cCvc
        hideKeyboard()
    }
    
    func copyBank() {
        pasteboard.string = cBankname
        hideKeyboard()
    }
    
    func copyKeylic() {
        pasteboard.string = kLicensekey
        hideKeyboard()
    }
    
    func copyKeypkg() {
        pasteboard.string = kSoftwarepkg
        hideKeyboard()
    }
    
    func copyKeyemail() {
        pasteboard.string = kEmailaddress
        hideKeyboard()
    }
    
    func copyKeyweb() {
        pasteboard.string = kWebaddress
        hideKeyboard()
    }
    
    func copyKeyseats() {
        pasteboard.string = kSeats
        hideKeyboard()
    }
}

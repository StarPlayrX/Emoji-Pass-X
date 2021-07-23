//
//  clipboard.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
//

import SwiftUI

extension ItemView {
    
    
    func copyToClipboard(_ string: String) {
        pasteboard.string = string
        hideKeyboard()
    }
    
    func copyUsernameX() {
        pasteboard.string = pUsername
        pasteboard.string = pPassword
        pasteboard.string = pWebsite
        pasteboard.string = pPhone
        pasteboard.string = pPin
        pasteboard.string = cCardnumber
        pasteboard.string = cExpdate

        pasteboard.string = cFullname
        pasteboard.string = cCvc
        pasteboard.string = cBankname

        pasteboard.string = kLicensekey

        pasteboard.string = kSoftwarepkg
        pasteboard.string = kEmailaddress

        pasteboard.string = kWebaddress
        pasteboard.string = kSeats

    }
    
    func copyPass() {
        hideKeyboard()
    }
    
    func copyWeb() {
        hideKeyboard()
    }
    
    func copyPhone() {
        hideKeyboard()
    }
    
    func copyPin() {
        hideKeyboard()
    }
    
    func copyCard() {
        hideKeyboard()
    }
    
    func copyExp() {
        hideKeyboard()
    }
    
    func copyFullName() {
        hideKeyboard()
    }
    
    func copyCVC() {
        hideKeyboard()
    }
    
    func copyBank() {
        hideKeyboard()
    }
    
    func copyKeylic() {
        hideKeyboard()
    }
    
    func copyKeypkg() {
        hideKeyboard()
    }
    
    func copyKeyemail() {
        hideKeyboard()
    }
    
    func copyKeyweb() {
        hideKeyboard()
    }
    
    func copyKeyseats() {
        hideKeyboard()
    }
    
}

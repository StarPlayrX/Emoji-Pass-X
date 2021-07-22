//
//  itemViewPasswordUI.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ItemView {
    //MARK: Password Stack
    func passwordStack(_ hideLabels: Bool) -> some View {
       VStack {
            Group {
                notesEditor("pNotes", note: $pNotes, keyboard: UIKeyboardType.alphabet, textContentType: UITextContentType.sublocality, hideLabels: hideLabels)
            }
            
            Group {
                //MARK: Username
                if !hideLabels { label(userName) }
                formFields(userName, item: $pUsername, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.username, action: copyUsername)
                
                //MARK: Password
                if !hideLabels {  label(passWord) }
                formFields(passWord, item: $pPassword, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.password, action: copyPass)
                
                //MARK: Web
                if !hideLabels { label(web) }
                
                formFields(web, item: $pWebsite, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.URL, action: copyWeb)
                
                //MARK: Phone
                if !hideLabels { label(phone) }
                
                formFields(phone, item: $pPhone, keyboard: UIKeyboardType.numbersAndPunctuation, textContentType: UITextContentType.telephoneNumber, action: copyPhone)
                
                //MARK: Pin
                
                if !hideLabels { label(pin) }
                formFields(pin, item: $pPin, keyboard: UIKeyboardType.numbersAndPunctuation, textContentType: UITextContentType.oneTimeCode, action: copyPin)
            }
        }
    }
}

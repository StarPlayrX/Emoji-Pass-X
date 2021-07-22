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
                field(userName, item: $pUsername, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.username)
                
                //MARK: Password
                if !hideLabels {  label(passWord) }
                field(passWord, item: $pPassword, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.password)
                
                //MARK: Web
                if !hideLabels { label(web) }
                
                field(web, item: $pWebsite, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.URL)
                
                //MARK: Phone
                if !hideLabels { label(phone) }
                
                field(phone, item: $pPhone, keyboard: UIKeyboardType.numbersAndPunctuation, textContentType: UITextContentType.telephoneNumber)
                
                //MARK: Pin
                
                if !hideLabels { label(pin) }
                field(pin, item: $pPin, keyboard: UIKeyboardType.numbersAndPunctuation, textContentType: UITextContentType.oneTimeCode)
            }
        }
    }
}

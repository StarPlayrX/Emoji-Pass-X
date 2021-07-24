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

            // MARK: There is a SwiftUI bug where keyboard is being dismissed after 1 key press when a Text Field runs in a ForEach Loop
            Group {
                if !hideLabels {label(userName)}
                formFields(
                    userName,
                    item: $pUsername,
                    keyboard: UIKeyboardType.asciiCapable,
                    textContentType: UITextContentType.username,
                    action: {copyToClipboard(pUsername)}
                )
                
                if !hideLabels {label(passWord)}
                formFields(
                    passWord,
                    item: $pPassword,
                    keyboard: UIKeyboardType.asciiCapable,
                    textContentType: UITextContentType.password,
                    action: {copyToClipboard(pPassword)}
                )
                
                if !hideLabels { label(phone) }
                formFields(
                    phone,
                    item: $pWebsite,
                    keyboard: UIKeyboardType.asciiCapable,
                    textContentType: UITextContentType.URL,
                    action: {copyToClipboard(pPhone)}
                )
                
                if !hideLabels { label(web) }
                formFields(
                    web,
                    item: $pPhone,
                    keyboard: UIKeyboardType.asciiCapable,
                    textContentType: UITextContentType.URL,
                    action: {copyToClipboard(pWebsite)}
                )
            
                if !hideLabels { label(pin) }
                formFields(
                    pin,
                    item: $pPin,
                    keyboard: UIKeyboardType.numbersAndPunctuation,
                    textContentType: UITextContentType.oneTimeCode,
                    action: {copyToClipboard(pPin)}
                )
            }
        }
    }
}

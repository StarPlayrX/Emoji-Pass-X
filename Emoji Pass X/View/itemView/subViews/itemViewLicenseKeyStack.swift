//
//  itemViewLicenseKeyStack.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ItemView {
    //MARK: licenseKeyStack
    func licenseKeyStack(_ hideLabels: Bool) -> some View {
        
        VStack {
            Group {
                notesEditor("kNotes", note: $kNotes, keyboard: UIKeyboardType.alphabet, textContentType: UITextContentType.sublocality, hideLabels: hideLabels)
            }
            
            // MARK: There is a SwiftUI bug where keyboard is being dismissed after 1 key press when a Text Field runs in a ForEach Loop
            Group {
                if !hideLabels {label(keypkg)}
                formFields(
                    keypkg,
                    item: $kSoftwarepkg,
                    keyboard: UIKeyboardType.asciiCapable,
                    textContentType: UITextContentType.organizationName,
                    action: { copyToClipboard(kSoftwarepkg) })
                
                if !hideLabels {label(keylic)}
                formFields(
                    keylic,
                    item: $kLicensekey,
                    keyboard: UIKeyboardType.asciiCapable,
                    textContentType: UITextContentType.givenName,
                    action: { copyToClipboard(kLicensekey) })
                
                if !hideLabels {label(keyemail)}
                formFields(
                    keyemail,
                    item: $kEmailaddress,
                    keyboard: UIKeyboardType.asciiCapable,
                    textContentType: UITextContentType.emailAddress,
                    action: { copyToClipboard(kEmailaddress) })
                
                if !hideLabels {label(keyweb)}
                formFields(
                    keyweb,
                    item: $kWebaddress,
                    keyboard: UIKeyboardType.asciiCapable,
                    textContentType: UITextContentType.URL,
                    action: { copyToClipboard(kWebaddress) })
                
                if !hideLabels {label(keyseats)}
                formFields(
                    keyseats,
                    item: $kSeats,
                    keyboard: UIKeyboardType.numbersAndPunctuation,
                    textContentType: UITextContentType.nickname,
                    action: { copyToClipboard(kSeats) })
            }
        }
    }
}

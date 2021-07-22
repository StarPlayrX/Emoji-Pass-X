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
            
            Group {
                if !hideLabels { label(keypkg) }
                formFields(keypkg, item: $kSoftwarepkg, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.organizationName, action: copyUsername)
                
                if !hideLabels {  label(keylic) }
                formFields(keylic, item: $kLicensekey, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.givenName, action: copyKeylic)
                
                if !hideLabels { label(keyemail) }
                formFields(keyemail, item: $kEmailaddress, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.emailAddress, action: copyKeyemail)
                
                if !hideLabels { label(keyweb) }
                formFields(keyweb, item: $kWebaddress, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.URL, action: copyKeyweb)
                
                if !hideLabels { label(keyseats) }
                formFields(keyseats, item: $kSeats, keyboard: UIKeyboardType.numbersAndPunctuation, textContentType: UITextContentType.nickname, action: copyKeyseats)
            }
        }
    }
}

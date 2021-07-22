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
                field(keypkg, item: $kSoftwarepkg, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.organizationName)
                
                if !hideLabels {  label(keylic) }
                field(keylic, item: $kLicensekey, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.givenName)
                
                if !hideLabels { label(keyemail) }
                
                field(keyemail, item: $kEmailaddress, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.emailAddress)
                
                if !hideLabels { label(keyweb) }
                
                field(keyweb, item: $kWebaddress, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.URL)
                
                if !hideLabels { label(keyseats) }
                field(keyseats, item: $kSeats, keyboard: UIKeyboardType.numbersAndPunctuation, textContentType: UITextContentType.nickname)
            }
        }
    }
}

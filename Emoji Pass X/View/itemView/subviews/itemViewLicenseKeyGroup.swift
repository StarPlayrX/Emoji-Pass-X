//
//  itemViewLicenseKeyStack.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ItemView {
    
    func licenseKeyGroup(_ hideLabels: Bool) -> some View {
        
        Group {
            notesEditor(
                "kNotes",
                note: $record.kNotes,
                keyboard: UIKeyboardType.alphabet,
                textContentType: UITextContentType.sublocality,
                hideLabels: hideLabels)
            
            let records : [ItemViewItems] = [
                ItemViewItems(
                    labl: keypkg,
                    text: $record.kSoftwarepkg,
                    copy: record.kSoftwarepkg,
                    keys: UIKeyboardType.asciiCapable,
                    type: UITextContentType.organizationName),
                ItemViewItems(
                    labl: keylic,
                    text: $record.kLicensekey,
                    copy: record.kLicensekey,
                    keys: UIKeyboardType.asciiCapable,
                    type: UITextContentType.givenName),
                ItemViewItems(
                    labl: keyemail,
                    text: $record.kEmailaddress,
                    copy: record.kEmailaddress,
                    keys: UIKeyboardType.asciiCapable,
                    type: UITextContentType.emailAddress),
                ItemViewItems(
                    labl: keyweb,
                    text: $record.kWebaddress,
                    copy: record.kWebaddress,
                    keys: UIKeyboardType.asciiCapable,
                    type: UITextContentType.URL),
                ItemViewItems(
                    labl: keyseats,
                    text: $record.kSeats,
                    copy: record.kSeats,
                    keys: UIKeyboardType.numbersAndPunctuation,
                    type: UITextContentType.nickname)
            ]
            
            // MARK: https://developer.apple.com/documentation/swiftui/foreach
            ForEach(records) { record in
                
                if !hideLabels {
                    label(record.labl)
                }
                
                formField(
                    record.labl,
                    boundText: record.text,
                    keyboard: record.keys,
                    textContentType: record.type,
                    action: {Clipboard().copyToClipBoard(record.copy, hide: false)})
            }
        }
    }
}

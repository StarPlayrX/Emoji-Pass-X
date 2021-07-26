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
            
            let records : [ItemViewRecords] = [
                ItemViewRecords(
                    labl: keypkg,
                    text: $record.kSoftwarepkg,
                    copy: record.kSoftwarepkg,
                    keys: UIKeyboardType.asciiCapable,
                    cntx: UITextContentType.organizationName),
                ItemViewRecords(
                    labl: keylic,
                    text: $record.kLicensekey,
                    copy: record.kLicensekey,
                    keys: UIKeyboardType.asciiCapable,
                    cntx: UITextContentType.givenName),
                ItemViewRecords(
                    labl: keyemail,
                    text: $record.kEmailaddress,
                    copy: record.kEmailaddress,
                    keys: UIKeyboardType.asciiCapable,
                    cntx: UITextContentType.emailAddress),
                ItemViewRecords(
                    labl: keyweb,
                    text: $record.kWebaddress,
                    copy: record.kWebaddress,
                    keys: UIKeyboardType.asciiCapable,
                    cntx: UITextContentType.URL),
                ItemViewRecords(
                    labl: keyseats,
                    text: $record.kSeats,
                    copy: record.kSeats,
                    keys: UIKeyboardType.numbersAndPunctuation,
                    cntx: UITextContentType.nickname)
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
                    textContentType: record.cntx,
                    action: {Clipboard().copyToClipBoard(record.copy, hide: false)})
            }
        }
    }
}

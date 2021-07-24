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
        
        Group {
            notesEditor(
                "kNotes",
                note: $kNotes,
                keyboard: UIKeyboardType.alphabet,
                textContentType: UITextContentType.sublocality,
                hideLabels: hideLabels)
            
            let records : [ItemViewRecords] = [
                ItemViewRecords(
                    labl: keypkg,
                    text: $kSoftwarepkg,
                    copy: kSoftwarepkg,
                    keys: UIKeyboardType.asciiCapable,
                    cntx: UITextContentType.organizationName),
                ItemViewRecords(
                    labl: keylic,
                    text: $kLicensekey,
                    copy: kLicensekey,
                    keys: UIKeyboardType.asciiCapable,
                    cntx: UITextContentType.givenName),
                ItemViewRecords(
                    labl: keyemail,
                    text: $kEmailaddress,
                    copy: kEmailaddress,
                    keys: UIKeyboardType.asciiCapable,
                    cntx: UITextContentType.emailAddress),
                ItemViewRecords(
                    labl: keyweb,
                    text: $kWebaddress,
                    copy: kWebaddress,
                    keys: UIKeyboardType.asciiCapable,
                    cntx: UITextContentType.URL),
                ItemViewRecords(
                    labl: keyseats,
                    text: $kSeats,
                    copy: kSeats,
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
                    action: {copyToClipboard(record.copy)})
            }
        }
    }
}

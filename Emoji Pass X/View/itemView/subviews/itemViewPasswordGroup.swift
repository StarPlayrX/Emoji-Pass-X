//
//  passwordGroup.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ItemView {
    
    func passwordGroup(_ hideLabels: Bool) -> some View {
        
        Group {
            notesEditor(
                "pNotes",
                note: $record.pNotes,
                keyboard: UIKeyboardType.alphabet,
                textContentType: UITextContentType.sublocality,
                hideLabels: hideLabels)
            
            let records : [ItemViewRecords] = [
                ItemViewRecords(
                    labl: userName,
                    text: $record.pUsername,
                    copy: record.pUsername,
                    keys: UIKeyboardType.asciiCapable,
                    type: UITextContentType.username),
                ItemViewRecords(
                    labl: passWord,
                    text: $record.pPassword,
                    copy: record.pPassword,
                    keys: UIKeyboardType.asciiCapable,
                    type: UITextContentType.password),
                ItemViewRecords(
                    labl: phone,
                    text: $record.pPhone,
                    copy: record.pPhone,
                    keys: UIKeyboardType.asciiCapable,
                    type: UITextContentType.URL),
                ItemViewRecords(
                    labl: web,
                    text: $record.pWebsite,
                    copy: record.pWebsite,
                    keys: UIKeyboardType.asciiCapable,
                    type: UITextContentType.telephoneNumber),
                ItemViewRecords(
                    labl: pin,
                    text: $record.pPin,
                    copy: record.pPin,
                    keys: UIKeyboardType.numbersAndPunctuation,
                    type: UITextContentType.oneTimeCode)
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

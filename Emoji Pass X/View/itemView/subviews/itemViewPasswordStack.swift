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
        
        Group {
            notesEditor(
                "pNotes",
                note: $pNotes,
                keyboard: UIKeyboardType.alphabet,
                textContentType: UITextContentType.sublocality,
                hideLabels: hideLabels)
            
            let records : [ItemViewRecords] = [
                ItemViewRecords(
                    labl: userName,
                    text: $pUsername,
                    copy: pUsername,
                    keys: UIKeyboardType.asciiCapable,
                    cntx: UITextContentType.username),
                ItemViewRecords(
                    labl: passWord,
                    text: $pPassword,
                    copy: pPassword,
                    keys: UIKeyboardType.asciiCapable,
                    cntx: UITextContentType.password),
                ItemViewRecords(
                    labl: phone,
                    text: $pPhone,
                    copy: pPhone,
                    keys: UIKeyboardType.asciiCapable,
                    cntx: UITextContentType.URL),
                ItemViewRecords(
                    labl: web,
                    text: $pWebsite,
                    copy: pWebsite,
                    keys: UIKeyboardType.asciiCapable,
                    cntx: UITextContentType.telephoneNumber),
                ItemViewRecords(
                    labl: pin,
                    text: $pPin,
                    copy: pPin,
                    keys: UIKeyboardType.numbersAndPunctuation,
                    cntx: UITextContentType.oneTimeCode)
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

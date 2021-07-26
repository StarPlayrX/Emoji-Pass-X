//
//  creditCardGroup.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ItemView {
    
    func creditCardGroup(_ hideLabels: Bool) -> some View {
        
        Group {
            notesEditor(
                "cNotes",
                note: $record.cNotes,
                keyboard: UIKeyboardType.alphabet,
                textContentType: UITextContentType.sublocality,
                hideLabels: hideLabels)
         
            let records : [ItemViewRecords] = [
                ItemViewRecords(
                    labl: bank,
                    text: $record.cBankname,
                    copy: record.cBankname,
                    keys: UIKeyboardType.asciiCapable,
                    type: UITextContentType.organizationName),
                ItemViewRecords(
                    labl: card,
                    text: $record.cCardnumber,
                    copy: record.cCardnumber,
                    keys: UIKeyboardType.numbersAndPunctuation,
                    type: UITextContentType.oneTimeCode),
                ItemViewRecords(
                    labl: fullName,
                    text: $record.cFullname,
                    copy: record.cFullname,
                    keys: UIKeyboardType.asciiCapable,
                    type: UITextContentType.givenName),
                ItemViewRecords(
                    labl: cvc,
                    text: $record.cCvc,
                    copy: record.cCvc,
                    keys: UIKeyboardType.asciiCapable,
                    type: UITextContentType.creditCardNumber),
                ItemViewRecords(
                    labl: exp,
                    text: $record.cExpdate,
                    copy: record.cExpdate,
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


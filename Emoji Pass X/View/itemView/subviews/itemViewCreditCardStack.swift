//
//  itemViewCreditCardStack.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ItemView {
    
    func creditCardStack(_ hideLabels: Bool) -> some View {
        
        Group {
            
            notesEditor(
                "cNotes",
                note: $cNotes,
                keyboard: UIKeyboardType.alphabet,
                textContentType: UITextContentType.sublocality,
                hideLabels: hideLabels)
         
            let records : [ItemViewRecords] = [
                ItemViewRecords(
                    labl: bank,
                    text: $cBankname,
                    copy: cBankname,
                    keys: UIKeyboardType.asciiCapable,
                    cntx: UITextContentType.organizationName),
                ItemViewRecords(
                    labl: card,
                    text: $cCardnumber,
                    copy: cCardnumber,
                    keys: UIKeyboardType.numbersAndPunctuation,
                    cntx: UITextContentType.oneTimeCode),
                ItemViewRecords(
                    labl: fullName,
                    text: $cFullname,
                    copy: cFullname,
                    keys: UIKeyboardType.asciiCapable,
                    cntx: UITextContentType.givenName),
                ItemViewRecords(
                    labl: cvc,
                    text: $cCvc,
                    copy: cCvc,
                    keys: UIKeyboardType.asciiCapable,
                    cntx: UITextContentType.creditCardNumber),
                ItemViewRecords(
                    labl: exp,
                    text: $cExpdate,
                    copy: cExpdate,
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


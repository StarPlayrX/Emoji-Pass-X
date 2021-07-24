//
//  itemViewCreditCardStack.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ItemView {
    
    //MARK: CreditCardStack
    func creditCardStack(_ hideLabels: Bool) -> some View {
        VStack {
            Group {
                notesEditor("cNotes", note: $cNotes, keyboard: UIKeyboardType.alphabet, textContentType: UITextContentType.sublocality, hideLabels: hideLabels)
            }
            
            // MARK: There is a SwiftUI bug where keyboard is being dismissed after 1 key press when a Text Field runs in a ForEach Loop
            Group {
                if !hideLabels {label(bank)}
                formFields(
                    bank,
                    item: $cBankname,
                    keyboard: UIKeyboardType.asciiCapable,
                    textContentType: UITextContentType.organizationName,
                    action: { copyToClipboard(cBankname) })
                
                if !hideLabels {label(card)}
                formFields(
                    card,
                    item: $cCardnumber,
                    keyboard: UIKeyboardType.numbersAndPunctuation,
                    textContentType: UITextContentType.URL,
                    action: {copyToClipboard(cCardnumber)})
                
                if !hideLabels {label(fullName)}
                formFields(
                    fullName,
                    item: $cFullname,
                    keyboard: UIKeyboardType.asciiCapable,
                    textContentType: UITextContentType.givenName,
                    action: {copyToClipboard(cFullname)})
                
                if !hideLabels {label(cvc)}
                formFields(
                    cvc,
                    item: $cCvc,
                    keyboard: UIKeyboardType.numbersAndPunctuation,
                    textContentType: UITextContentType.oneTimeCode,
                    action: {copyToClipboard(cCvc)})
                
                if !hideLabels {label(exp)}
                formFields(
                    exp,
                    item: $cExpdate,
                    keyboard: UIKeyboardType.numbersAndPunctuation,
                    textContentType: UITextContentType.nickname,
                    action: {copyToClipboard(cExpdate)} )
            }
        }
    }
}

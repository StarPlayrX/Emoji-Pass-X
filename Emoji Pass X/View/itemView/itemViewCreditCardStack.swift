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

            let items = [
                BindingInfo(text: bank,     bind: $cBankname,    copy: cBankname),
                BindingInfo(text: card,     bind: $cCardnumber,  copy: cCardnumber),
                BindingInfo(text: fullName, bind: $cFullname,    copy: cFullname),
                BindingInfo(text: cvc,      bind: $cCvc,         copy: cCvc),
                BindingInfo(text: exp,      bind: $cExpdate,     copy: cExpdate)
            ]
            Group {
                ForEach( items, id: \.self) { item in
                    if !hideLabels { label(item.text) }
                    formFields(
                        item.text,
                        item: item.bind,
                        keyboard: UIKeyboardType.asciiCapable,
                        textContentType: UITextContentType.password,
                        action: { copyToClipboard(item.copy) }
                    )
                }
            }
        }
    }
}

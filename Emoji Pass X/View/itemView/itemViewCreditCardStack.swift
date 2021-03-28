//
//  itemViewCreditCardStack.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
//

import SwiftUI

extension ItemView {
    
    //MARK: CreditCardStack
    func creditCardStack(_ hideLabels: Bool) -> some View {

         VStack {
            Group {
                notesEditor("cNotes", note: $cNotes, keyboard: UIKeyboardType.alphabet, textContentType: UITextContentType.sublocality, hideLabels: hideLabels)
            }
            
            Group {
                if !hideLabels { label(bank) }
                field(bank, item: $cBankname, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.organizationName)
                
                if !hideLabels {  label(card) }
                field(card, item: $cCardnumber, keyboard: UIKeyboardType.numbersAndPunctuation, textContentType: UITextContentType.URL)
                
                if !hideLabels { label(fullName) }
                
                field(fullName, item: $cFullname, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.givenName)
                
                if !hideLabels { label(cvc) }
                
                field(cvc, item: $cCvc, keyboard: UIKeyboardType.numbersAndPunctuation, textContentType: UITextContentType.oneTimeCode)
                
                //MARK: Exp
                if !hideLabels { label(exp) }
                field(exp, item: $cExpdate, keyboard: UIKeyboardType.numbersAndPunctuation, textContentType: UITextContentType.nickname)
            }
        }
    }
    
}

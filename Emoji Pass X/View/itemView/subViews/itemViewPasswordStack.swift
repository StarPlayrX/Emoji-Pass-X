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
            VStack {
                notesEditor("pNotes", note: $pNotes, keyboard: UIKeyboardType.alphabet, textContentType: UITextContentType.sublocality, hideLabels: hideLabels)
                
            }
            
            VStack {
                
                let items = [
                    BindingInfo(text: userName, bind: $pUsername, copy: pUsername),
                    BindingInfo(text: web,      bind: $pWebsite,  copy: pWebsite),
                    BindingInfo(text: passWord, bind: $pPassword, copy: pPassword),
                    BindingInfo(text: phone,    bind: $pPhone,    copy: pPhone),
                    BindingInfo(text: pin,      bind: $pPin,      copy: pPin)
                ]
                
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

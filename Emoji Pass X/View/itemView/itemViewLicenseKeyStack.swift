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
        
        VStack {
            Group {
                notesEditor("kNotes", note: $kNotes, keyboard: UIKeyboardType.alphabet, textContentType: UITextContentType.sublocality, hideLabels: hideLabels)
            }

            let items = [
                BindingInfo(text: keypkg,   bind: $kSoftwarepkg,  copy: kSoftwarepkg),
                BindingInfo(text: keylic,   bind: $kLicensekey,   copy: kLicensekey),
                BindingInfo(text: keyemail, bind: $kEmailaddress, copy: kEmailaddress),
                BindingInfo(text: keyweb,   bind: $kWebaddress,   copy: kWebaddress),
                BindingInfo(text: keyseats, bind: $kSeats,        copy: kSeats)
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

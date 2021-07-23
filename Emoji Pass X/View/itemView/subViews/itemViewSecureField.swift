//
//  itemViewSecureField.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/22/21.
//

import SwiftUI

import SwiftUI

extension ItemView {
    
    func itemViewSecureField(_ text: String, note: Binding<String>, textContentType: UITextContentType) -> some View {
        SecureField("",text: note)
            .textContentType(textContentType)
            .multilineTextAlignment(.leading)
            .allowsHitTesting(!listItem.lock)
            .padding(.top, 7)
            .padding(.bottom, 1)
            .padding(.leading, 9)
            .padding(.trailing, 7)
            .frame(minHeight: 36, maxHeight: 360, alignment: Alignment.topLeading )
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(labelColor3, lineWidth: 1)
            )
            .padding()
            .padding(.leading, -4)
    }
}

//
//  itemViewTextEditor.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/22/21.
//

import SwiftUI

extension ItemView {
            
    func itemViewTextEditor(_ text: String, note: Binding<String>, keyboard: UIKeyboardType, textContentType: UITextContentType) -> some View {
        TextEditor(text: note)
            .lineSpacing(3)
            .multilineTextAlignment(.leading)
            .textContentType(textContentType)
            .keyboardType(keyboard)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .font(.body)
            .padding(.top, 4)
            .padding(.bottom, 4)
            .padding(.leading, 9)
            .padding(.trailing, 7)
            .frame(minHeight: 45, maxHeight: 450, alignment: Alignment.topLeading )
            
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(labelColor3, lineWidth: 1)
            )
            .padding()
            .padding(.leading, -4)
    }
}

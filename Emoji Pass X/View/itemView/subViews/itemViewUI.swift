//
//  itemViewUI.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ItemView {
    
    func label(_ text: String) -> some View {
        HStack(spacing: spacing) {
            Text(text)
                .foregroundColor(labelColor)
            Spacer()
        }
        .padding(.horizontal, horizontal)
        .padding(.bottom, bottom / 2)
        .padding(.leading, margin * 1.5)
        .padding(.trailing, margin * 1.5)
    }
    
    func notesLabel(_ text: String) -> some View {
        HStack(spacing: spacing) {
            Text("Notes")
                .foregroundColor(labelColor)
            Spacer()
            
            switch text {
            case "pNotes":
                Button(action: {copyToClipboard(pNotes)}) {Image(systemName: clipBoard)}
                    .padding(.horizontal, clipPadding)
            case "cNotes":
                Button(action: {copyToClipboard(cNotes)}) {Image(systemName: clipBoard)}
                    .padding(.horizontal, clipPadding)
            case "kNotes":
                Button(action: {copyToClipboard(kNotes) }) {Image(systemName: clipBoard)}
                    .padding(.horizontal, clipPadding)
            default:
                Button(action: {copyToClipboard(cNotes)}) {Image(systemName: clipBoard)}
                    .padding(.horizontal, clipPadding)
            }
        }
        .padding(.bottom, 0)
        .padding(.horizontal, horizontal + (margin * 1.5))
    }
    
    func notesEditor(_ text: String, note: Binding<String>, keyboard: UIKeyboardType, textContentType: UITextContentType, hideLabels: Bool) -> some View {
        VStack(spacing: spacing) {
            
            VStack {
                notesLabel(text)
                if !listItem.lock {
                    itemViewTextEditor(text, note: note, keyboard: keyboard, textContentType: textContentType)
                } else {
                    itemViewSecureField(text, note: note, textContentType: textContentType)
                }
            }
        }
    }
    
    func formFields(_ text: String, item: Binding<String>, keyboard: UIKeyboardType, textContentType: UITextContentType, action: @escaping () -> Void ) -> some View {
        
        HStack(spacing: spacing) {
            
            if listItem.lock {
                SecureField("\(enter) \(text)", text: item)
                    .textContentType(textContentType)
                    .allowsHitTesting(!listItem.lock)
            } else {
                TextField("\(enter) \(text)", text: item)
                    .textContentType(textContentType)
                    .keyboardType(keyboard)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            
            Button(action: action) {Image(systemName: clipBoard)}
                .padding(.horizontal, clipPadding)
            
        }
        .padding(.bottom, bottom)
        .padding(.horizontal, horizontal + (margin * 1.5))
    }
    
}

//
//  itemViewUI.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
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
            
            if text == "pNotes" {
                Button(action: copyPnotes) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == "cNotes" {
                Button(action: copyCnotes) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == "kNotes" {
                Button(action: copyKnotes) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            }
            
        }
        .padding(.horizontal, horizontal)
        .padding(.bottom, 0)
        .padding(.leading, margin * 1.5)
        .padding(.trailing, margin * 1.5)
    }
    
    func notesEditor(_ text: String, note: Binding<String>, keyboard: UIKeyboardType, textContentType: UITextContentType, hideLabels: Bool) -> some View {
        VStack(spacing: spacing) {
            
            VStack {
                notesLabel(text)
                if !listItem.lock {
                    
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
                    
                } else {
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
            
            Button(action: action) { Image(systemName: clipBoard) }.padding(.horizontal, clipPadding)
            
        }
        .padding(.bottom, bottom)
        .padding(.horizontal, horizontal + (margin * 1.5))
    }
    
}

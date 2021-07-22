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
    
    func field(_ text: String, item: Binding<String>, keyboard: UIKeyboardType, textContentType: UITextContentType) -> some View {
        
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
            
            //MARK: Switch case did not place nice here - Type check error
            if text == userName {
                Button(action: copyUsername) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == passWord {
                Button(action: copyPass) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == phone {
                Button(action: copyPhone) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == pin {
                Button(action: copyPin) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == web {
                Button(action: copyWeb) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == card {
                Button(action: copyCard) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == exp {
                Button(action: copyExp) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == fullName {
                Button(action: copyFullName) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == cvc {
                Button(action: copyCVC) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == bank {
                Button(action: copyBank) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == keypkg {
                Button(action: copyKeypkg) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == keylic {
                Button(action: copyKeylic) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == keyemail {
                Button(action: copyKeyemail) { Image(systemName: clipBoard) }
                    .padding(.horizontal, 5.0)
                
            } else if text == keyseats {
                Button(action: copyKeyseats) { Image(systemName: clipBoard) }
                    .padding(.horizontal, 5.0)
            } else if text == keyweb {
                Button(action: copyKeyweb) { Image(systemName: clipBoard) }
                    .padding(.horizontal, 5.0)
            }
        }
        .padding(.bottom, bottom)
        .padding(.horizontal, horizontal + (margin * 1.5))
    }
    
}

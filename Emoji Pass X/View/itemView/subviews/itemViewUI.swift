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
        .padding(.bottom, bottom / 2)
        .padding(.horizontal, horizontal + (margin * 1.5))
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
                    .accentColor(Color(.systemBlue))
            case "cNotes":
                Button(action: {copyToClipboard(cNotes)}) {Image(systemName: clipBoard)}
                    .padding(.horizontal, clipPadding)
                    .accentColor(Color(.systemBlue))
            case "kNotes":
                Button(action: {copyToClipboard(kNotes)}) {Image(systemName: clipBoard)}
                    .padding(.horizontal, clipPadding)
                    .accentColor(Color(.systemBlue))
            default:
                Button(action: {copyToClipboard(cNotes)}) {Image(systemName: clipBoard)}
                    .padding(.horizontal, clipPadding)
                    .accentColor(Color(.systemBlue))
            }
        }
        .padding(.bottom, 0)
        .padding(.horizontal, horizontal + (margin * 1.5))
    }
    
    func notesEditor(_ text: String, note: Binding<String>, keyboard: UIKeyboardType, textContentType: UITextContentType, hideLabels: Bool) -> some View {
        VStack(spacing: spacing) {
            
            if !hideLabels {
                notesLabel(text)
            }
            
            if !listItem.lock {
                
                TextEditor(text: note)
                    .lineSpacing(4)
                    .multilineTextAlignment(.leading)
                    .keyboardType(keyboard)
                    .textContentType(textContentType)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .font(.body)
                    .padding(.top, 4)
                    .padding(.bottom, 4)
                    .padding(.leading, 9)
                    .padding(.trailing, 7)
                    .frame(minHeight: 45, maxHeight: 450, alignment: Alignment.topLeading )
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(labelColor3, lineWidth: 1))
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
    
    func formField(_ label: String, boundText: Binding<String>, keyboard: UIKeyboardType, textContentType: UITextContentType, action: @escaping () -> Void ) -> some View {
        HStack(spacing: spacing) {
            if listItem.lock {
                SecureField("\(enter) \(label)", text: boundText)
                    .textContentType(textContentType)
                    .allowsHitTesting(!listItem.lock)
            } else {
                TextField("\(enter) \(label)", text: boundText)
                    .textContentType(textContentType)
                    .keyboardType(keyboard)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            Button(action: action) { Image(systemName: clipBoard) }.padding(.horizontal, clipPadding)
                .accentColor(Color(.systemBlue))
        }
        .padding(.bottom, bottom)
        .padding(.horizontal, horizontal + (margin * 1.5))
    }
}

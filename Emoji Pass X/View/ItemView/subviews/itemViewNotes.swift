//
//  itemViewNotes.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//
import SwiftUI

extension ItemView {
    
    func notesLabel(_ text: String) -> some View {
        HStack(spacing: spacing) {
            Text(NotesStrings.Notes.rawValue)
                .foregroundColor(Colors.secondary)
            Spacer()
                            
            let clip = Clipboard()
            
            switch text {
            case NotesStrings.pNotes.rawValue:
                Button(action: {clip.copyToClipBoard(record.pNotes, hide: true)}) {Image(systemName: clipBoard)}
            case NotesStrings.cNotes.rawValue:
                Button(action: {clip.copyToClipBoard(record.cNotes, hide: true)}) {Image(systemName: clipBoard)}
            case NotesStrings.kNotes.rawValue:
                Button(action: {clip.copyToClipBoard(record.kNotes, hide: true)}) {Image(systemName: clipBoard)}
            default:
                Button(action: {clip.copyToClipBoard(record.cNotes, hide: true)}) {Image(systemName: clipBoard)}
            }
        }
        .buttonStyle(SystemBlueButton())
        .padding(.bottom, 0)
        .padding(.horizontal, clipPadding + horizontal + (margin * 1.5))
    }
    
    func notesEditor(_ text: String,
                     note: Binding<String>,
                     keyboard: UIKeyboardType,
                     textContentType: UITextContentType, hideLabels: Bool) -> some View {
        VStack(spacing: spacing) {
            
            if !hideLabels {notesLabel(text)}
            
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
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Colors.systemGray3, lineWidth: 1))
                    .padding()
                    .padding(.leading, -4)
            } else {
                SecureField(String(),text: note)
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
                            .stroke(Colors.systemGray3, lineWidth: 1)
                    )
                    .padding()
                    .padding(.leading, -4)
            }
        }
    }
}

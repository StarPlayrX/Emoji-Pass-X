//
//  itemViewPasswordGroup.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//
import SwiftUI

extension ItemView {
    
    func passwordGroup(_ hideLabels: Bool) -> some View {
        
        Group {
            notesEditor(
                NotesStrings.pNotes.rawValue,
                note: $record.pNotes,
                keyboard: UIKeyboardType.alphabet,
                textContentType: UITextContentType.sublocality,
                hideLabels: hideLabels)
            
            let records : [ItemViewItems] = [
                ItemViewItems(
                    labl: userName,
                    text: $record.pUsername,
                    copy: record.pUsername,
                    keys: UIKeyboardType.asciiCapable,
                    type: UITextContentType.username),
                ItemViewItems(
                    labl: passWord,
                    text: $record.pPassword,
                    copy: record.pPassword,
                    keys: UIKeyboardType.asciiCapable,
                    type: UITextContentType.password),
                ItemViewItems(
                    labl: phone,
                    text: $record.pPhone,
                    copy: record.pPhone,
                    keys: UIKeyboardType.asciiCapable,
                    type: UITextContentType.URL),
                ItemViewItems(
                    labl: web,
                    text: $record.pWebsite,
                    copy: record.pWebsite,
                    keys: UIKeyboardType.asciiCapable,
                    type: UITextContentType.telephoneNumber),
                ItemViewItems(
                    labl: pin,
                    text: $record.pPin,
                    copy: record.pPin,
                    keys: UIKeyboardType.numbersAndPunctuation,
                    type: UITextContentType.oneTimeCode)
            ]
            
            // MARK: https://developer.apple.com/documentation/swiftui/foreach
            ForEach(records) { record in
                
                if !hideLabels {
                    label(record.labl)
                }
                
                formField(
                    record.labl,
                    boundText: record.text,
                    keyboard: record.keys,
                    textContentType: record.type,
                    action: {Clipboard().copyToClipBoard(record.copy, hide: false)})
            }
        }
    }
}

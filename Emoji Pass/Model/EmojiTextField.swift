//
//  Classes.swift
//  Emoji Pass
//
//  Created by StarPlayrX on 11/14/20.
//

import UIKit
import SwiftUI


extension TextFieldWrapperView {

    func makeUIView(context: UIViewRepresentableContext<TextFieldWrapperView>) -> UITextField {
        let textField = EmojiTextField()
        textField.delegate = context.coordinator
        textField.font = .boldSystemFont(ofSize: 72)
        textField.textAlignment = .center
        textField.text = gEmoji
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {}
}

class EmojiTextField: UITextField {

    // required for iOS 13
    override var textInputContextIdentifier: String? { "" }
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        return nil
    }
}

class TFCoordinator: NSObject, UITextFieldDelegate {
    var parent: TextFieldWrapperView

    init(_ textField: TextFieldWrapperView) {
        self.parent = textField
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

            let currentText = textField.text! + string
            gEmoji = String(currentText.prefix(4))
            return currentText.count <= 4

       }
}


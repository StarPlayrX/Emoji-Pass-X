//
//  MasterTextField.swift
//  Emoji Pass
//
//  Created by StarPlayrX on 11/14/20.
//

import UIKit
import SwiftUI

extension MasterTextFieldWrapperView {

    func makeUIView(context: UIViewRepresentableContext<MasterTextFieldWrapperView>) -> UITextField {
        let textField = MasterTextField()
        textField.delegate = context.coordinator
        textField.font = .boldSystemFont(ofSize: 72)
        textField.textAlignment = .center
        //textField.text = gMaster
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {}
}

class MasterTextField: UITextField {

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

class TFCoordinatorM: NSObject, UITextFieldDelegate {
    var parent: MasterTextFieldWrapperView

    init(_ textField: MasterTextFieldWrapperView) {
        self.parent = textField
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            let currentText = textField.text! + string
            gMaster = String(currentText.prefix(4))
            return currentText.count <= 4

       }
    
   
}



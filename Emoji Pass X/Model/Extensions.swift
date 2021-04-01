//
//  Extensions.swift
//  Emoji Pass X
//
//  Created by StarPlayrX on 3/2/21.
//

import UIKit
import SwiftUI
import Foundation

public extension UITextField {
    override var textInputMode: UITextInputMode? {
        return UITextInputMode.activeInputModes.filter { $0.primaryLanguage == "emoji" }.first ?? super.textInputMode
    }
}

extension StringProtocol {
    var data: Data { .init(utf8) }
    var bytes: [UInt8] { .init(utf8) }
}

extension Data {
    var bytes: [UInt8] { [UInt8](self) }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Notification.Name {
    static let save = Notification.Name("save")
    static let refresh = Notification.Name("refresh")
}

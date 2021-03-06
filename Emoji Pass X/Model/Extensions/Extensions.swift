//
//  Extensions.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/2/21.
//

import SwiftUI
import Foundation
import CoreData

// Fire Emoji Keyboard on iOS
public extension UITextField {
    override var textInputMode: UITextInputMode? {
        return UITextInputMode.activeInputModes.filter { $0.primaryLanguage == "emoji" }.first ?? super.textInputMode
    }
}

// Data to Bytes, Bytes to Data
extension StringProtocol {
    var data: Data {.init(utf8)}
    var bytes: [UInt8] {.init(utf8)}
}

// Notification Names
extension Notification.Name {
    static let save = Notification.Name("save")
    static let refresh = Notification.Name("refresh")
}

// Reports if our device have a notch
extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

extension View {

    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}


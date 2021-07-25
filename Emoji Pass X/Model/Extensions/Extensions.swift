//
//  Extensions.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/2/21.
//

import SwiftUI
import Foundation
import CommonCrypto
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

// Will Hide the keyboard on iOS
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
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

// Krypto
extension Data {
    var bytes: [UInt8] {[UInt8](self)}

    func encrypt(key: Data) -> Data? {
        let krpto = Krypto()
        
        guard
            let iv = krpto.randomGenerateBytes(count: kCCBlockSizeAES128),
            
            let ciphertext =
                krpto.crypt(
                    operation: kCCEncrypt,
                    algorithm: kCCAlgorithmAES,
                    options:   kCCOptionPKCS7Padding,
                    key: key,
                    initializationVector: iv,
                    dataIn: self)
        else {
            return nil
        }
        
        return iv + ciphertext
    }
    
    func decrypt(key: Data) -> Data? {
        let krpto = Krypto()
        
        guard
            count > kCCBlockSizeAES128
        else {
            return nil
        }
        
        let iv = prefix(kCCBlockSizeAES128)
        let ciphertext = suffix(from: kCCBlockSizeAES128)
        
        return
            krpto.crypt(
                operation: kCCDecrypt,
                algorithm: kCCAlgorithmAES,
                options: kCCOptionPKCS7Padding,
                key: key,
                initializationVector: iv,
                dataIn: ciphertext)
    }
}

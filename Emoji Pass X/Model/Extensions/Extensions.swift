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

public extension UITextField {
    override var textInputMode: UITextInputMode? {
        return UITextInputMode.activeInputModes.filter { $0.primaryLanguage == "emoji" }.first ?? super.textInputMode
    }
}

extension StringProtocol {
    var data: Data {.init(utf8)}
    var bytes: [UInt8] {.init(utf8)}
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

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

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

extension ListItem {
    static func getFetchRequest() -> NSFetchRequest<ListItem> {
        if let request = ListItem.fetchRequest() as? NSFetchRequest<ListItem> {
            request.entity = ListItem.entity()
            request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
            return request
        }
    }
}

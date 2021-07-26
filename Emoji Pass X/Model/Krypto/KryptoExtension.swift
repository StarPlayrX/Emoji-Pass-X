//
//  KryptoExtension.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/26/21.
//

import Foundation
import CommonCrypto

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

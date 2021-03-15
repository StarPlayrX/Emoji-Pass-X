//
//  Cryto.swift
//  Emoji Pass X
//
//  Created by StarPlayrX on 11/14/20.
//

import CommonCrypto
import Foundation
import UIKit


func encryptData(string: String, key: Data) -> Data {
    let emptyData = Data()
    
    //MARK: Do no encrypt empty Strings (Saves disk space time)
    if string.isEmpty {
        return emptyData
    }
    
    if let secret = string.data(using: .utf8), let encrypted = secret.encryptAES256_CBC_PKCS7_IV(key: key) {
        return encrypted
    } else {
        return emptyData
    }
}

func decryptData(data: Data, key: Data) -> String {
    let emptyString = ""
    
    //MARK: Do not decrypt empty Data (Saves processing time)
    if data.isEmpty {
        return emptyString
    }
    
    if let decryptedBytes = data.decryptAES256_CBC_PKCS7_IV(key: key), let decrypted = String(data: decryptedBytes, encoding: .utf8) {
        return decrypted
    } else {
        return emptyString
    }
}

func crypt(operation: Int, algorithm: Int, options: Int, key: Data,
        initializationVector: Data, dataIn: Data) -> Data? {
    return key.withUnsafeBytes { keyUnsafeRawBufferPointer in
        return dataIn.withUnsafeBytes { dataInUnsafeRawBufferPointer in
            return initializationVector.withUnsafeBytes { ivUnsafeRawBufferPointer in
                // Give the data out some breathing room for PKCS7's padding.
                let dataOutSize: Int = dataIn.count + kCCBlockSizeAES128*2
                let dataOut = UnsafeMutableRawPointer.allocate(byteCount: dataOutSize,
                    alignment: 1)
                defer { dataOut.deallocate() }
                var dataOutMoved: Int = 0
                let status = CCCrypt(CCOperation(operation), CCAlgorithm(algorithm),
                    CCOptions(options),
                    keyUnsafeRawBufferPointer.baseAddress, key.count,
                    ivUnsafeRawBufferPointer.baseAddress,
                    dataInUnsafeRawBufferPointer.baseAddress, dataIn.count,
                    dataOut, dataOutSize, &dataOutMoved)
                guard status == kCCSuccess else { return nil }
                return Data(bytes: dataOut, count: dataOutMoved)
            }
        }
    }
}

func randomGenerateBytes(count: Int) -> Data? {
    let bytes = UnsafeMutableRawPointer.allocate(byteCount: count, alignment: 1)
    defer { bytes.deallocate() }
    let status = CCRandomGenerateBytes(bytes, count)
    guard status == kCCSuccess else { return nil }
    return Data(bytes: bytes, count: count)
}


extension Data {
    /// Encrypts for you with all the good options turned on: CBC, an IV, PKCS7
    /// padding (so your input data doesn't have to be any particular length).
    /// Key can be 128, 192, or 256 bits.
    /// Generates a fresh IV for you each time, and prefixes it to the
    /// returned ciphertext.
    func encryptAES256_CBC_PKCS7_IV(key: Data) -> Data? {
        guard let iv = randomGenerateBytes(count: kCCBlockSizeAES128) else { return nil }
        // No option is needed for CBC, it is on by default.
        guard let ciphertext = crypt(operation: kCCEncrypt,
                                    algorithm: kCCAlgorithmAES,
                                    options: kCCOptionPKCS7Padding,
                                    key: key,
                                    initializationVector: iv,
                                    dataIn: self) else { return nil }
        return iv + ciphertext
    }
    
    /// Decrypts self, where self is the IV then the ciphertext.
    /// Key can be 128/192/256 bits.
    func decryptAES256_CBC_PKCS7_IV(key: Data) -> Data? {
        guard count > kCCBlockSizeAES128 else { return nil }
        let iv = prefix(kCCBlockSizeAES128)
        let ciphertext = suffix(from: kCCBlockSizeAES128)
        return crypt(operation: kCCDecrypt, algorithm: kCCAlgorithmAES,
            options: kCCOptionPKCS7Padding, key: key, initializationVector: iv,
            dataIn: ciphertext)
    }
}



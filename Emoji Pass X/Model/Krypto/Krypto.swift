//
//  KryptoClass.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import CommonCrypto
import Foundation
import UIKit

protocol KryptoProtocol {
    func createEncryptedKey(emojiKey: String, key: Data) -> Data
    func decryptEncryptedKey(emojiData: Data, key: Data) -> String
    func encrypt(string: String, key: Data, encoding: String.Encoding) -> Data
    func decrypt(data: Data, key: Data, encoding: String.Encoding) -> String
    func emojiParentKey() -> Data
    func emojiRecordKey() -> String
    func krypt(operation: Int, algorithm: Int, options: Int, key: Data, initializationVector: Data, dataIn: Data) -> Data?
    func randomGenerateBytes(count: Int) -> Data?
}

struct Krypto {
    func createEncryptedKey(emojiKey: String, key: Data) -> Data {
        let encryptedKey = Krypto().encrypt(string: emojiKey, key: key, encoding: .utf8)
        return encryptedKey
    }
    
    func decryptEncryptedKey(emojiData: Data, key: Data) -> String {
        let decryptedKey = Krypto().decrypt(data: emojiData, key: key, encoding: .utf8)
        return decryptedKey
    }
    
    func encrypt(string: String, key: Data, encoding: String.Encoding) -> Data {
        guard !string.isEmpty,
              let secret = string.data(using: encoding),
              let encrypted = secret.encrypt(key: key)
        else {
            return Data()
        }
        
        return encrypted
    }
    
    func decrypt(data: Data, key: Data, encoding: String.Encoding) -> String {
        guard !data.isEmpty,
              let secret = data.decrypt(key: key),
              let decrypted = String(data: secret, encoding: encoding)
        else {
            return String()
        }
        
        return decrypted
    }
    
    //MARK: - Consistently creates our MasterKey for the entire app
    func emojiParentKey() -> Data {
        let pool = Emoji().pool
        let a = 2
        let b = 1
        let d = Int(pool.count / 8) - a
        var c = pool.count - b
        var e = String()
        
        for _ in 1...8 {
            c -= d
            e += pool[c]
        }
        
        return e.data
    }
    
    //MARK: - Random Emoji String used for each Record
    func emojiRecordKey() -> String {
        let pool = Emoji().pool
        var a = String()
        
        for _ in 1...8 {
            let b = Int.random(in: 0..<pool.count)
            a += pool[b]
        }
        
        return a
    }
    
    
    // https://www.splinter.com.au/2019/06/09/pure-swift-common-crypto-aes-encryption/ Chris Hulbert
    
    func krypt(operation: Int, algorithm: Int, options: Int, key: Data, initializationVector: Data, dataIn: Data) -> Data? {
        
        key.withUnsafeBytes { keyUnsafeRawBufferPointer in
            dataIn.withUnsafeBytes { dataInUnsafeRawBufferPointer in
                initializationVector.withUnsafeBytes { ivUnsafeRawBufferPointer in
                    
                    let dataOutSize: Int = dataIn.count + kCCBlockSizeAES128 * 2
                    
                    let dataOut = UnsafeMutableRawPointer.allocate(
                            byteCount: dataOutSize,
                            alignment: 1)
                    defer {dataOut.deallocate()}
                    
                    var dataOutMoved: Int = 0
                    
                    guard
                        let success =
                            Optional(CCCrypt(
                                        CCOperation(operation),
                                        CCAlgorithm(algorithm),
                                        CCOptions(options),
                                        keyUnsafeRawBufferPointer.baseAddress,
                                        key.count,
                                        ivUnsafeRawBufferPointer.baseAddress,
                                        dataInUnsafeRawBufferPointer.baseAddress,
                                        dataIn.count,
                                        dataOut,
                                        dataOutSize,
                                        &dataOutMoved)),
                        success == kCCSuccess
                    else {
                         return nil
                    }
                    
                    return Data(bytes: dataOut, count: dataOutMoved)
                }
            }
        }
    }
    
    func rndBytes(count: Int) -> Data? {
        let bytes = UnsafeMutableRawPointer.allocate(byteCount: count, alignment: 1)
        defer { bytes.deallocate() }
        
        guard
            let success = Optional(CCRandomGenerateBytes(bytes, count)),
            success == kCCSuccess
        else {
            return nil
        }
        
        return Data(bytes: bytes, count: count)
    }
}

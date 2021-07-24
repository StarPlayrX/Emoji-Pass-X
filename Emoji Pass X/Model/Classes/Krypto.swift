//
//  Krypto.swift
//  Emoji Pass X
//
//  crypt, randomGenerateBytes, encryptAES256_CBC_PKCS7_IV, decryptAES256_CBC_PKCS7_IV by Chris Hulbert on 2019/06/09.
//  encryptData, decryptData by Todd Bruss

// https://www.splinter.com.au/2019/06/09/pure-swift-common-crypto-aes-encryption/ by Chris Hulbert

import CommonCrypto
import Foundation
import UIKit

class Krypto {
    func encryptData(string: String, key: Data) -> Data {
        let emptyData = Data()
        
        //MARK: Do no encrypt empty Strings (Saves disk space time)
        if string.isEmpty {return emptyData}
        
        if let secret = string.data(using: .utf8),
           let encrypted = secret.encryptAES256_CBC_PKCS7_IV(key: key){
            return encrypted
        }
        
        return emptyData
    }
    
    func decryptData(data: Data, key: Data) -> String {
        let emptyString = String()
        
        //MARK: Do not decrypt empty Data (Saves processing time)
        if data.isEmpty {return emptyString}
        
        if let decryptedBytes =
            data.decryptAES256_CBC_PKCS7_IV(key: key),
           let decrypted =
            String(data: decryptedBytes, encoding: .utf8) {
            return decrypted
        }
        
        return emptyString
    }
    
    func crypt(operation: Int, algorithm: Int, options: Int, key: Data,
               initializationVector: Data, dataIn: Data) -> Data? {
        return key.withUnsafeBytes { keyUnsafeRawBufferPointer in
            return dataIn.withUnsafeBytes { dataInUnsafeRawBufferPointer in
                return initializationVector.withUnsafeBytes { ivUnsafeRawBufferPointer in
                    let dataOutSize: Int =
                        dataIn.count + kCCBlockSizeAES128 * 2
                    let dataOut =
                        UnsafeMutableRawPointer.allocate(
                            byteCount: dataOutSize,
                            alignment: 1)
                    defer { dataOut.deallocate() }
                    var dataOutMoved: Int = 0
                    let status =
                        CCCrypt(
                            CCOperation(operation), CCAlgorithm(algorithm),
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
}

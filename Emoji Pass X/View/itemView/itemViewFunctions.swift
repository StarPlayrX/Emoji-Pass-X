//
//  itemViewFunctions.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
//

import Foundation

extension ItemView {
    
   func createEncryptedKey(emojiKey: String) -> Data {
       let encryptedKey = encryptData(string: emojiKey, key: privateKey.parentKey)
       return encryptedKey
   }

    func decryptEncryptedKey(emojiData: Data) -> String {
       let decryptedKey = decryptData(data: emojiData, key: privateKey.parentKey)
       return decryptedKey
   }

    
    //MARK: Function to keep text length in limits
    func limitText(_ upper: Int) {
        if listItem.emoji.count > upper {
            listItem.emoji = String(listItem.emoji.prefix(upper))
            hideKeyboard()
        }
    }
    
    
    //MARK: Consistently creates our MasterKey for the entire app
    func emojiParentKey() -> Data {
        let a = 2
        let b = 1
        let d = Int(pool.count / 8) - a
        var c = pool.count - b
        
        var e = ""
        
        for _ in 1...8 {
            c -= d
            e += pool[c]
        }
        
        return e.data
    }

    //MARK: Random Emoji String used for each Record
    func emojiRecordKey() -> String {
        var a = ""
        
        for _ in 1...8 {
            let b = Int.random(in: 0..<pool.count)
            a += pool[b]
        }
        
        return a
    }
    
}

//
//  Global.swift
//  Emoji Pass
//
//  Created by Todd Bruss on 11/14/20.
//

import Foundation
import SwiftUI

var gEncryptionKey = Data()
var gSafe = Dictionary<String,Any>()


func saveMasterKey(masterKey: String) {
    
    if masterKey.count == 4 {
        UserDefaults.standard.setValue(masterKey, forKey: "gMaster")
        
        if gEncryptionKey.count == 0 {
            gEncryptionKey = randomGenerateBytes(count: 32)!
        }
        
        UserDefaults.standard.setValue(gEncryptionKey, forKey: "gEncryptionKey")

    }
}

func loadMasterKey() -> String {
    
    gEncryptionKey = UserDefaults.standard.data(forKey: "gEncryptionKey") ?? Data()

    let master = UserDefaults.standard.string(forKey: "gMaster") ?? ""
    return master
}


func saveSettings() {
    UserDefaults.standard.setValue(gSafe, forKey: "gSafe")
}


func loadSettings() {
    
    if let dictionary = UserDefaults.standard.dictionary(forKey: "gSafe"), dictionary.count > 0 {
        gSafe = dictionary
    } else {
        gSafe = ["🍔🍟🌮🥤" : [Data(), Data()]]
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

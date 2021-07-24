//
//  clipboard.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ItemView {
    func copyToClipboard(_ string: String) {
        pasteboard.string = string
        
        #if !targetEnvironment(macCatalyst)
            hideKeyboard()
        #endif
    }
    
    func copyToClipboardII(_ string: String) {
        pasteboard.string = string
        hideKeyboard()
    }
}

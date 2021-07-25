//
//  Clipboard.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

protocol Duplicate {
    func copyToClipBoard(_ string: String, hide: Bool)
    func hideKeyBoard()
}

struct Clipboard: Duplicate {
    func copyToClipBoard(_ string: String, hide: Bool) {
        UIPasteboard.general.string = string
        if hide {hideKeyBoard()}
    }
    
    func hideKeyBoard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

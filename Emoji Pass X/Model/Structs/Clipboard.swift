//
//  Clipboard.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

protocol Duplicate {
    func copyToClipBoard(_ string: String, hide: Bool)
}

struct Clipboard: Duplicate {
    func copyToClipBoard(_ string: String, hide: Bool) {
        UIPasteboard.general.string = string
        if hide {HideKeys().hideKeyboard()}
    }
}

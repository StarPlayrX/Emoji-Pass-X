//
//  HideKeyboard.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/27/21.
//

import UIKit

struct HideKeys {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


//
//  BindingStruct.swift
//  Emoji Pass X
//
//  Created by M1 on 7/22/21.
//

import SwiftUI

struct BindingInfo: Hashable {
    var text: String
    var bind: Binding<String>
    var copy: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(text)
        hasher.combine(copy)
    }
    
    static func == (lhs: BindingInfo, rhs: BindingInfo) -> Bool {
        return lhs.text == rhs.text && lhs.copy == rhs.copy
    }
}

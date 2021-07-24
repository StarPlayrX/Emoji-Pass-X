//
//  BindingStruct.swift
//  Emoji Pass X
//
//  Created by Todd Brus on 7/22/21.
//

import SwiftUI

/// This is used on our ItemView's Records / UI
struct ItemViewRecords: Identifiable {
    let labl: String
    var text: Binding<String>
    var copy: String
    var keys: UIKeyboardType
    var cntx: UITextContentType
    var id: String { labl }
}

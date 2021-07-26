//
//  ItemViewItems.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/26/21.
//

import SwiftUI

/// This is used on our ItemView's Records / UI
struct ItemViewItems: Identifiable {
    let labl: String
    var text: Binding<String>
    var copy: String
    var keys: UIKeyboardType
    var type: UITextContentType
    var id: String { labl }
}

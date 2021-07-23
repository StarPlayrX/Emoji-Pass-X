//
//  PrivateParts.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

//MARK: Private Parts
class PrivateParts: ObservableObject {
    @Published var parentKey = Data()
    @Published var recordKey = Data()
    @Published var recordStr = String()
}

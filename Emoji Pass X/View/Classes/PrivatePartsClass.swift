//
//  PrivateParts.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
//

import SwiftUI

//MARK: Private Parts
class privateParts: ObservableObject {
    @Published var parentKey = Data()
    @Published var recordKey = Data()
    @Published var recordStr = String()
}

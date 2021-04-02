//
//  SecurityClass.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
//

import Foundation

public class Security: ObservableObject {
    @Published var lockScreen = true
    @Published var signOn = true
    @Published var cloudDebug = false
    @Published var doesNotHaveIcloud = false
    @Published var isSimulator = false
    @Published var checkForSim = true
    @Published var catLock = true
    @Published var isValid = false
    @Published var isDeleteListViewValid = false
    @Published var isEditing = false
    @Published var isCatEditViewSaved = false
    @Published var isListItemViewSaved = false

    @Published var isItemSaved = false
    @Published var previousEmoji = ""
    @Published var isCategoryNew = false


}

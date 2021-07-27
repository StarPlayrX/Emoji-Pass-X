//
//  Security.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//
import Foundation

public class Security: ObservableObject {
    @Published var lockScreen = true
    @Published var signOn = true
    @Published var catLock = true
    @Published var haltAnimations = true
    @Published var haltLockScreenAnimation = false
    @Published var doesNotHaveIcloud = false
    @Published var isSimulator = false
    @Published var isValid = false
    @Published var isDeleteListViewValid = false
    @Published var isEditing = false
    @Published var isCatEditViewSaved = false
    @Published var isListItemViewSaved = false
    @Published var isItemSaved = false
    @Published var isCategoryNew = false
    @Published var previousEmoji = String()
}

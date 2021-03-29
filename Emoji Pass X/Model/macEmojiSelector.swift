//
//  macEmojiSelector.swift
//  Emoji Pass X
//
//  Created by M1 on 3/28/21.
//

import Foundation

func macEmojiSelector() {
    
    #if targetEnvironment(macCatalyst)
        let commandControlMask = (CGEventFlags.maskCommand.rawValue | CGEventFlags.maskControl.rawValue)
        let commandControlMaskFlags = CGEventFlags(rawValue: commandControlMask)

         // Press Space key once
        let space = CGEventSource(stateID: .hidSystemState)
        let keyDown = CGEvent(keyboardEventSource: space, virtualKey: 49 as CGKeyCode, keyDown: true)
        keyDown?.flags = commandControlMaskFlags
        keyDown!.post(tap: .cghidEventTap)
        let keyUp = CGEvent(keyboardEventSource: space, virtualKey: 49 as CGKeyCode, keyDown: false)
        keyUp?.flags = commandControlMaskFlags
        keyUp?.post(tap: .cghidEventTap)
    #endif

}

//Function to keep text length in limits
func emojiTextTail(_ tail: Int, inputText: String) -> String {
    inputText.count > tail ? String(inputText.suffix(tail)) : inputText
}

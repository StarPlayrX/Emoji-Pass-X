//
//  Mac.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/28/21.
//

import Foundation
import UIKit

class Mac {
    func macEmojiSelector() {
        #if targetEnvironment(macCatalyst)
            let commandControlMask = (CGEventFlags.maskCommand.rawValue | CGEventFlags.maskControl.rawValue)
            let commandControlMaskFlags = CGEventFlags(rawValue: commandControlMask)

            // Press Space key once
            let space = CGEventSource(stateID: .hidSystemState)
            
            let keyDown = CGEvent(keyboardEventSource: space, virtualKey: 49 as CGKeyCode, keyDown: true)
            keyDown?.flags = commandControlMaskFlags
            keyDown?.post(tap: .cghidEventTap)
            
            let keyUp = CGEvent(keyboardEventSource: space, virtualKey: 49 as CGKeyCode, keyDown: false)
            keyUp?.flags = commandControlMaskFlags
            keyUp?.post(tap: .cghidEventTap)
        #endif
    }
}

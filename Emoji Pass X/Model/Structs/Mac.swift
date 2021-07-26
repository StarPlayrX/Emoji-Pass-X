//
//  Mac.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/28/21.
//

import Foundation
import UIKit

class Mac: NSObject {
    
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
    
    func buildMenu(_ builder: UIMenuBuilder){
        if UIDevice.current.userInterfaceIdiom == .mac {
            
            let input = "S"
            let saves = "Save"
            
            let refreshCommand = UIKeyCommand(
                input: input,
                modifierFlags: [.command],
                action: #selector(AppDelegate.save)
            )
            
            refreshCommand.title = saves
            
            let saveDataMenu = UIMenu(
                title: saves,
                image: nil,
                identifier: UIMenu.Identifier(saves),
                options: .displayInline,
                children: [refreshCommand]
            )
            
            builder.insertChild(saveDataMenu, atStartOfMenu: .file)
        }
    }
    
    

}

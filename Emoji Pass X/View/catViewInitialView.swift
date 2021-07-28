//
//  catViewInitialView.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/31/21.
//

import SwiftUI

extension CatView {
    func refreshAllObjects() {
        managedObjectContext.refreshAllObjects()
    }
    
    func intialView() -> some View {
        Group {

            // Ternary does not work here. Don't know why?

            // macOS has a drawing issue on the second go, currently doing the signOn once until it's fixed.
            // when fixed remove security.signOn
            if security.lockScreen && security.signOn {
                
                // Lock Screen
                catViewLockScreen()
                    .onAppear(perform: {catStruct.showLockScreen(security: security)})

            } else {
                
                // Main Screen
                catViewMain()
                    .onAppear(perform: hideKeyboard)
            }
        }
    }
}

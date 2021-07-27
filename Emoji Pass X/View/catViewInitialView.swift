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
            if security.lockScreen {
                
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

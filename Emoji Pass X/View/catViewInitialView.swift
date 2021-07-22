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
            if security.lockScreen {
                catViewLockStack()
                    .onAppear(perform: showLockScreen)
            } else {
                catViewMain()
                    .onAppear(perform: hideKeyboard)
            }
        }
    }
}

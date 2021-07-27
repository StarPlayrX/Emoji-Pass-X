//
//  catViewContinue.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/24/21.
//

import SwiftUI

extension CatView {
    func catViewContinue() -> some View {
        Group {
            Button("Continue") {
                security.doesNotHaveIcloud = catStruct.checkForCloudKit()
                
                if !security.doesNotHaveIcloud {
                    security.lockScreen = false
                }
            }
            .alert(isPresented: $security.doesNotHaveIcloud, content: {
                Alert(title: Text("We're sorry."),
                      message: Text("Please go to Settings and log into your iCloud Account."),
                      dismissButton: .default(Text("OK")) {security.doesNotHaveIcloud = false})
            })
            .frame(maxWidth: continueUpdater ? 375 : 373,  maxHeight: continueUpdater ? 266 : 264, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .keyboardShortcut(.defaultAction)
        }
        .padding(.horizontal, 50)
        .padding(.vertical, 100)
    }
}


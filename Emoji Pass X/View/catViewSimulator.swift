//
//  catViewSimulator.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/24/21.
//

import SwiftUI

extension CatView {
    func catViewSimulator() -> some View {
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
            .padding(.horizontal, 50)
            .padding(.vertical, 100)
            .frame(maxWidth: 375, maxHeight: 266, alignment: .center)
        }
    }
}

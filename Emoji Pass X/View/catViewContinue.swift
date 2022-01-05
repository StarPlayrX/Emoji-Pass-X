//
//  catViewContinue.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/24/21.
//

import SwiftUI
import LocalAuthentication


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
            .scaleEffect()
            .frame(maxWidth: 375,  maxHeight: 266, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .minimumScaleFactor(0.99)
            .keyboardShortcut(.defaultAction)
        }
        .padding(.horizontal, 50)
        .padding(.vertical, 100)
    }
    
    func macAuth() -> some View {
        Group {
            Button("Continue with Local Authentication") {
                security.doesNotHaveIcloud = catStruct.checkForCloudKit()
                
                if !security.doesNotHaveIcloud {
                    localAuthenticator()
                }
            }
           
            .alert(isPresented: $security.doesNotHaveIcloud, content: {
                Alert(title: Text("We're sorry."),
                      message: Text("Please go to Settings and log into your iCloud Account."),
                      dismissButton: .default(Text("OK")) {security.doesNotHaveIcloud = false})
            })
            .scaleEffect()
            .minimumScaleFactor(0.99)
            .keyboardShortcut(.defaultAction)
        }
        .padding(.horizontal, 50)
        .padding(.vertical, 100)
    }
    
    
    func localAuthenticator() {
        let context = LAContext()

        // check whether biometric authentication is possible
            // it's possible, so go ahead and use it
            let reason = "Owner authnetication is required to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
                // authentication has now completed
                if success {
                    // authenticated successfully
                    print(success)
                    if !security.doesNotHaveIcloud {
                        security.lockScreen = false
                    }
                } else {
                    print(error?.localizedDescription)
                }
            }
      
    }
    
}


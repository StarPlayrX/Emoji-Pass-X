//
//  catViewSignOnButton.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/24/21.
//

import SwiftUI
import AuthenticationServices

extension CatView {
    func catViewSignOnButton() -> some View {
        Group {
            SignInWithAppleButton(
                .continue,
                onRequest: { (request) in
                    /// We are only using Sign on with Apple as a controlled Gateway
                },
                onCompletion: { (result) in
                    switch result {
                    case .success(_):
                        security.lockScreen = false
                        
                        /// Due to a Sign on with Apple bug, we will only authenticate once on the front end
                        if UIDevice.current.userInterfaceIdiom == .mac {
                            security.signOn = false
                        }
                        break
                    case .failure(let error):
                        print(error)
                        break
                    }
                }
            )
            .signInWithAppleButtonStyle( Theme.isGlobalDark ? .white : .black)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke( Theme.isGlobalDark ? Color.black : Color.white, lineWidth: 2)
            )
            .padding(.horizontal, 50)
            .padding(.vertical, 100)
            .frame(maxWidth: 350, maxHeight: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)            
        }
    }
}

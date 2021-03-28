//
//  lockStack.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
//

import SwiftUI
import CoreData
import AuthenticationServices


//MARK: lockStack

extension CatView {
    func catViewLockStack() -> some View {
        return VStack {
            
            Text("Emoji Pass X").font(.largeTitle).minimumScaleFactor(0.75).padding(.top, 100)
            
            HStack {
                
                Image("Emoji Pass X_logo4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 230.0,height:230)
                    
                    .background(Color.clear)
            }.overlay(
                RoundedRectangle(cornerRadius: 48)
                    .stroke(  UITraitCollection.current.userInterfaceStyle == .dark ? Color.gray : Color.black, lineWidth: 2)
            )
            
            Text(copyright).font(.callout).minimumScaleFactor(0.75).padding(.top, 10)
            
            if security.signOn && !security.isSimulator {
                SignInWithAppleButton(.continue,
                                      onRequest: { (request) in
                                        //Set up request
                                        //MARK: We are only using Sign on with Apple as a controlled Gateway
                                      },
                                      onCompletion: { (result) in
                                        switch result {
                                        case .success(_):
                                            //MARK: print(authorization)
                                            //MARK: to use authorization add: let authorization to (_)
                                            security.lockScreen = false
                                            
                                            //MARK: Due to a Sign on with Apple bug, we will only authenticate once on the front end
                                            if UIDevice.current.userInterfaceIdiom == .mac {
                                                security.signOn = false
                                            }
                                            break
                                        case .failure(let error):
                                            print(error)
                                            break
                                        }
                                      }).overlay(
                                        RoundedRectangle(cornerRadius: 9)
                                            .stroke( UITraitCollection.current.userInterfaceStyle == .dark ? Color.white : Color.black, lineWidth: 1)
                                      )
                    .padding(.horizontal, 50)
                    .padding(.vertical, 100)
                    .frame(maxWidth: 320,  maxHeight: 220, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                
            } else {
                
                if security.isSimulator {
                    Button("Continue with Simulator") {
                        security.lockScreen = false
                    }
                    .padding(.horizontal, 50)
                    .padding(.vertical, 100)
                    .frame(maxWidth: 375,  maxHeight: 266, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    
                } else {
                    Group {
                        Button("Continue with Device") {
                            security.lockScreen = false
                        }
                        .frame(maxWidth: 375,  maxHeight: 266, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .keyboardShortcut(.defaultAction)
                    }
                    
                    .padding(.horizontal, 50)
                    .padding(.vertical, 100)
                }
            }
            
        }.signInWithAppleButtonStyle( UITraitCollection.current.userInterfaceStyle == .dark ? .white : .black)
    }
}



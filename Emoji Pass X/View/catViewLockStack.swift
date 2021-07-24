//
//  lockStack.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//
import SwiftUI
import CoreData
import AuthenticationServices

extension CatView {
    func catViewLockStack() -> some View {
        VStack {
            Text("Emoji Pass X").font(.largeTitle).minimumScaleFactor(0.75).padding(.top, 100)
            
            HStack {
                Image("Emoji Pass X_logo4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 230.0, height: 230)
                    .background(Color.clear)
            }.overlay (
                RoundedRectangle(cornerRadius: 48)
                    .stroke(isGlobalDark ? Color.gray : Color.white, lineWidth: 2)
            )
            
            Text(copyright).font(.callout).minimumScaleFactor(0.75).padding(.top, 10)
            
            if security.signOn && !security.isSimulator {
                SignInWithAppleButton(.continue,
                                      onRequest: { (request) in
                                        //MARK: We are only using Sign on with Apple as a controlled Gateway
                                      },
                                      onCompletion: { (result) in
                                        switch result {
                                        case .success(_):
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
                                      })
                    .signInWithAppleButtonStyle( isGlobalDark ? .white : .black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke( isGlobalDark ? Color.black : Color.white, lineWidth: 2)
                    )
                    .padding(.horizontal, 50)
                    .padding(.vertical, 100)
                    .frame(maxWidth: 350,  maxHeight: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            } else if security.isSimulator {
                Button("Continue") {
                    security.doesNotHaveIcloud = checkForCloudKit()
                    
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
                .frame(maxWidth: 375, maxHeight: 266, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            } else {
                Group {
                    Button("Continue") {
                        security.doesNotHaveIcloud = checkForCloudKit()
                        
                        if !security.doesNotHaveIcloud {
                            security.lockScreen = false
                        }
                    }
                    .alert(isPresented: $security.doesNotHaveIcloud, content: {
                        Alert(title: Text("We're sorry."),
                              message: Text("Please go to Settings and log into your iCloud Account."),
                              dismissButton: .default(Text("OK")) {security.doesNotHaveIcloud = false})
                    })
                    .frame(maxWidth: 375,  maxHeight: 266, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .keyboardShortcut(.defaultAction)
                }
                .padding(.horizontal, 50)
                .padding(.vertical, 100)
            }
        }
        .onAppear(perform: {isGlobalDark = UIScreen.main.traitCollection.userInterfaceStyle == .dark})
        .onDisappear(perform: {isGlobalDark = UIScreen.main.traitCollection.userInterfaceStyle == .dark})
    }
}

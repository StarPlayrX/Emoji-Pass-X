//
//  lockScreen.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//
import SwiftUI

extension CatView {
    func catViewLockScreen() -> some View {
        VStack {
            Text("Emoji Pass X").font(.largeTitle).minimumScaleFactor(0.75).padding(.top, 100)
            
            HStack {
                Image("Emoji Pass X_logo4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageUpdater ? 232.0 : 230.0, height: imageUpdater ? 232.0 : 230.0)
                    .background(Color.clear)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 48)
                    .stroke(Global.isGlobalDark ? Color.gray : Color.white, lineWidth: 2)
            )
            .onAppear(perform:{imageUpdater.toggle()})


            Text(copyright).font(.callout).minimumScaleFactor(0.75).padding(.top, 10)
            
            if security.signOn && !security.isSimulator {
                
                // 1 Sign On | Continue with Apple
                catViewSignOnButton()

            } else if security.isSimulator {
                
                // 2 Skip Sign On in Simulator
                catViewSimulator()


            } else {
                
                // 3 Continue button
                catViewContinue()
                    .onAppear(perform:{continueUpdater.toggle()})

            }
        }
        .transition(.opacity)

        .onAppear(perform: {Global.isGlobalDark = UIScreen.main.traitCollection.userInterfaceStyle == .dark})
        .onDisappear(perform: {Global.isGlobalDark = UIScreen.main.traitCollection.userInterfaceStyle == .dark})

    }

}

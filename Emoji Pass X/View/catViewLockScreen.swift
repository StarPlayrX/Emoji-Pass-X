//
//  lockScreen.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//
import SwiftUI



extension CatView {

    
    func catViewLockScreen() -> some View {
        Group {
            Text("Emoji Pass X")
                .font(.largeTitle)
                .minimumScaleFactor(0.75)
                .padding(.top, 100)
                .padding(.bottom, 20)

            Image("Emoji Pass X_logo4")
                .resizable()
                .scaledToFit()
                .background(Color.clear)
                .padding(1)
                .frame(width: 230, height: 230)
                .overlay(
                    RoundedRectangle(cornerRadius: 48)
                        .stroke(Global.isGlobalDark ? Color.gray : Color.white, lineWidth: 2)
                )
                .animation(security.lockScreen ? .easeInOut(duration: 1.0).repeatForever(autoreverses: true) : (nil))
                .animation(security.lockScreen ? .spring(response: 1.0, dampingFraction: 0.1, blendDuration: 0.25).repeatForever(autoreverses: true) : (nil))

            Text(AppStrings.copyright.rawValue)
                .font(.callout)
                .minimumScaleFactor(0.75)
                .padding(.top, 10)
            
            if UIDevice.current.userInterfaceIdiom == .mac  {
            
                macAuth()
              
            } else if security.signOn && !security.isSimulator {

                // 1 Sign On | Continue with Apple
                catViewSignOnButton()

            } else if security.isSimulator {
                
                // 2 Skip Sign On in Simulator
                catViewSimulator()

            } else {
                
                // 3 Continue button
                catViewContinue()
            }
        }
        .animation(.easeOut(duration: 0.75))
        .transition(.opacity)
        .onAppear(perform: {Global.isGlobalDark = UIScreen.main.traitCollection.userInterfaceStyle == .dark})
        .onDisappear(perform: {Global.isGlobalDark = UIScreen.main.traitCollection.userInterfaceStyle == .dark})
    }
}

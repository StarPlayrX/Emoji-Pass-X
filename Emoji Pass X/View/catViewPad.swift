//
//  catViewPad.swift
//  Emoji Pass X
//
//  Created by M1 on 7/22/21.
//

import SwiftUI

extension CatView {
    
    func catViewPad() -> some View {
        Group {
            VStack {
                Group {
                    Text("Emoji Pass X").font(.largeTitle).minimumScaleFactor(0.75)
                    HStack {
                        Image("Emoji Pass X_logo4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 230.0,height:230)
                            .background(Color.clear)
                    }.overlay (
                        RoundedRectangle(cornerRadius: 48)
                            .stroke( GlobalVariables.isGlobalDark  ? Color.gray : Color.white, lineWidth: 2)
                    )
                    
                    Text(copyright)
                        .font(.callout)
                        .minimumScaleFactor(0.75)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                    Text("The premiere password manager for macOS, iPadOS and iOS")
                        .font(.callout)
                        .minimumScaleFactor(0.75)
                        .multilineTextAlignment(.center)
                        .padding(.trailing, 30)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                    Text("Your data is stored privately in your own iCloud account.")
                        .font(.callout)
                        .minimumScaleFactor(0.75)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                }
                Spacer()
            }
            
            catViewStack() //allows Wider column on iPad (workaround for SideBar bug)
                .onDisappear(perform: saveItems)
                .onAppear(perform: saveItems)
            
            Text("")//Dummy Detail View
        }
    }
}


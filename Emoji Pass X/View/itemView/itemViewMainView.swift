//
//  itemViewMainView.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
//

import SwiftUI
import Combine

extension ItemView {
    
    func mainView() -> some View {
        
        GeometryReader { geometry in
            ScrollView {
                VStack() {
                    HStack() {
                        TextField(emoji, text: $listItem.emoji)
                            .background(labelColor2)
                            .cornerRadius(radius)
                            .fixedSize(horizontal: false, vertical: true)
                            .onReceive(Just(listItem.emoji)) { x in limitText(x) }
                           
                            .font(.system(size: geometry.size.width == smallestWidth ? emojiFontSize - 10 : emojiFontSize))
                            .minimumScaleFactor(1)
                            .multilineTextAlignment(.center)
                            .frame(height: geometry.size.width == smallestWidth ? emojiFrameWidth - 25 : emojiFrameWidth )
                            .frame(width: geometry.size.width == smallestWidth ? emojiFrameWidth - 50 : emojiFrameWidth - 25 )
                            .padding(.bottom, geometry.size.width == smallestWidth ? -10 : -10)
                            .padding(.leading, geometry.size.width == smallestWidth ? 10 : 10 )
                            .padding(.trailing, geometry.size.width == smallestWidth ? 10 : 10 )
                        TextField(name, text: $listItem.name)
                            .font(.largeTitle)
                            .padding(.bottom, geometry.size.width == smallestWidth ? -20 : -20)
                            .keyboardType(.asciiCapable)
                            .minimumScaleFactor(0.8)
                        Spacer()
                    }
                    
                    
                    //MARK: let template = ["💳 Cards", "🔒 Passwords", "🔑 Keys"]
                    switch listItem.templateId {
                    
                    case 0:
                        if UIDevice.current.userInterfaceIdiom == .pad ||  UIDevice.current.userInterfaceIdiom == .mac {
                            geometry.size.height <= 512 ? creditCardStack(true) : creditCardStack(false)
                        } else {
                            geometry.size.height <= 568 ? creditCardStack(!isIPhoneX()) : creditCardStack(false)
                        }
                    case 1:
                        if UIDevice.current.userInterfaceIdiom == .pad ||  UIDevice.current.userInterfaceIdiom == .mac {
                            geometry.size.height <= 512 ? passwordStack(true) : passwordStack(false)
                        } else {
                            geometry.size.height <= 568 ? passwordStack(!isIPhoneX()) : passwordStack(false)
                        }
                    case 2:
                        if UIDevice.current.userInterfaceIdiom == .pad ||  UIDevice.current.userInterfaceIdiom == .mac {
                            geometry.size.height <= 512 ? licenseKeyStack(true) : licenseKeyStack(false)
                        } else {
                            geometry.size.height <= 568 ? licenseKeyStack(!isIPhoneX()) : licenseKeyStack(false)
                        }
                    default:
                        if UIDevice.current.userInterfaceIdiom == .pad ||  UIDevice.current.userInterfaceIdiom == .mac {
                            geometry.size.height <= 512 ? passwordStack(true) : passwordStack(false)
                        } else {
                            geometry.size.height <= 568 ? passwordStack(!isIPhoneX()) : passwordStack(false)
                        }
                    }
                    
                }
                .onDisappear(perform: { save() })
                .onAppear(perform: { clearNewText() })
                .toolbar {
                    
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        
                        if UIDevice.current.userInterfaceIdiom == .mac {
                            Button(action: save )
                                { Text("Save") }
                            Button(action: macEmojiSelector )
                                { Text("Emoji") }
                        }
                        
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        
                        Button(action: { listItem.lock = !listItem.lock;save() })
                        {
                            if !listItem.lock {
                                Image(systemName: "lock.open")
                            } else {
                                Image(systemName: "lock.fill")
                            }
                        }
                        Button(action: { listItem.star = !listItem.star;save() })
                        {
                            if listItem.star {
                                Image(systemName: "star.fill")
                            } else {
                                Image(systemName: "star")
                                
                            }
                        }
                    }
                    
                    ToolbarItemGroup(placement: .bottomBar) {
                        Picker("", selection: $listItem.templateId) {
                            ForEach(templateIds, id: \.self) {
                                
                                if UIDevice.current.userInterfaceIdiom == .mac {
                                    Text(template[$0])
                                } else {
                                    geometry.size.width == smallestWidth ? Text(template[$0].prefix(1)) : Text(template[$0].prefix(6))
                                }
                                
                            }
                            .font(.largeTitle)
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                }
            } .navigationBarTitle( geometry.size.width <= 374 ? "Pass X" : "Emoji Pass X", displayMode: .inline)
        }
        
        .onTapGesture {
            hideKeyboard()
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            save()
            presentationMode.wrappedValue.dismiss()
        }
    }
}

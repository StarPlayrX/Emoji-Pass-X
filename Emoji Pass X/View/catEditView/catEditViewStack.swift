//
//  catEditViewStack.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
//

import SwiftUI
import Combine

extension CatEditView {
    
    func catEditViewGroup() -> some View {
        Group {
            GeometryReader { geometry in
                
                VStack {
                    HStack {
                        
                        TextField(emoji, text: $listItem.emoji)
                        .background(labelColor2)
                        .cornerRadius(radius)
                        .fixedSize(horizontal: false, vertical: true)
                            .onReceive(Just(listItem.emoji)) { _ in limitText() }
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
                    
                    if geometry.size.width == smallestWidth {
                        stack(true)
                    } else {
                        stack(false)
                    }
                    
                    if listItem.uuidString != "Stars" && listItem.uuidString != "Everything" {
                        
                        HStack {
                            Text("Default template: \(template[selectedTemplate]).")
                                .padding(.horizontal, horizontal)
                                .padding(.leading, margin * 1.5)
                                .padding(.trailing, margin * 1.5)
                                .foregroundColor(labelColor)
                                .padding(.bottom, -32)
                                .padding(.top, 16)
                            Spacer()
                            
                            
                        }
                        
                        Spacer()
                        
                    }
                    
                    Spacer()
                    
                }
                .padding(.top, UIDevice.current.userInterfaceIdiom == .mac ? -52 : 0)
                .toolbar {
                    
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        if UIDevice.current.userInterfaceIdiom == .mac {
                            Button(action: save )
                                { Text("Save") }
                            Button(action: macEmojiSelector )
                                { Text("Emoji") }
                            
                        }
                    }
                    
                    
                    ToolbarItemGroup(placement: .bottomBar) {
                        Picker("", selection: $selectedTemplate) {
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
                .onAppear(perform: {
                    clearNewText()
                })
                .onDisappear(perform: { save() })
            }
        }
    }
}

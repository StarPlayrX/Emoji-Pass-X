//
//  catEditViewStack.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI
import Combine

extension CatEditView {
    
    func Stars() {
        listItem.name = "All Stars"
        listItem.uuidString = "Stars"
        listItem.emoji = "⭐️"
        listItem.desc = "A store for all my favorites."
        security.previousEmoji = listItem.emoji
    }
    
    func Everything() {
        listItem.name = "Flashlight"
        listItem.uuidString = "Everything"
        listItem.emoji = "🔦"
        listItem.desc = "A store for all my records."
        security.previousEmoji = listItem.emoji
    }
    
    func catEditViewGroup() -> some View {
        Group {
            GeometryReader { geometry in
                VStack {
                    HStack {
                        TextField(emoji, text: $listItem.emoji)
                            .background(labelColor2)
                            .cornerRadius(radius)
                            .fixedSize(horizontal: false, vertical: true)
                        
                            .onReceive(Just(prevEmoji)) { _ in limitText() }
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
                    
                    geometry.size.width == smallestWidth ? stack(true) : stack(false)
                        
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
                        .padding(.bottom, 20)
                    }
                    
                    if security.isCategoryNew {
                        VStack {
                            if listItem.uuidString != "Stars" {
                                HStack {
                                    Button(action: Stars )
                                        { Text("Create an All Stars Category") }
                                        .padding(.top, 20)
                                        .padding(.leading, 12)
                                    Spacer()
                                }
                            }
                            
                            if listItem.uuidString != "Everything" {
                                HStack {
                                    
                                    Button(action: Everything )
                                        { Text("Create a Flashlight Category") }
                                        .padding(.top, 20)
                                        .padding(.leading, 12)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle( "Category", displayMode: .inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        if UIDevice.current.userInterfaceIdiom == .mac || UIDevice.current.userInterfaceIdiom == .pad  {
                            Button(action: { security.isCatEditViewSaved = true; save(); } )
                                    { Text("Save") }
                        }
                     
                        if UIDevice.current.userInterfaceIdiom == .mac  {
                            Button(action: macEmojiSelector )
                                { Text("Emoji") }
                        }
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        if UIDevice.current.userInterfaceIdiom == .mac || UIDevice.current.userInterfaceIdiom == .pad {
                            Picker("", selection: $selectedTemplate) {
                                ForEach(templateIds, id: \.self) {
                                    geometry.size.width == smallestWidth ? Text(template[$0].prefix(1)) : Text(template[$0].prefix(6))
                                }
                                .font(.largeTitle)
                                .pickerStyle(SegmentedPickerStyle())
                            }
                        }
                    }
                    
                    ToolbarItemGroup(placement: .bottomBar) {
                        Picker("", selection: $selectedTemplate) {
                            ForEach(templateIds, id: \.self) {
                                geometry.size.width == smallestWidth ? Text(template[$0].prefix(1)) : Text(template[$0].prefix(6))
                            }
                            .font(.largeTitle)
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                }
                .alert(isPresented: $security.isCatEditViewSaved, content: {
                    Alert(title: Text("Save"),
                          message: Text("Changes have been saved."),
                          dismissButton: .default(Text("OK")) { security.isCatEditViewSaved = false })
                })
                .onAppear(perform: {
                    clearNewText()
                })
                .onDisappear(perform: save )
            }
        }
    }
}

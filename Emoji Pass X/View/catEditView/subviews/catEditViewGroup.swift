//
//  catEditViewGroup.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI
import Combine

extension CatEditView {
    
    func catEditViewGroup() -> some View {
        Group {
            GeometryReader { geometry in
                VStack {
                    
                    catEditViewHeader(geometry)
                    
                    geometry.size.width == smallestWidth ? stack(true) : stack(false)
                        
                    if listItem.uuidString != "Stars" && listItem.uuidString != "Everything" {
                        catEditViewDefaultTemplate()
                    }
                    
                    if security.isCategoryNew {
                        catEditViewNewCategory()
                    }
                }
                .navigationBarTitle( "Category", displayMode: .inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        if UIDevice.current.userInterfaceIdiom == .mac || UIDevice.current.userInterfaceIdiom == .pad  {
                            Button(action: { security.isCatEditViewSaved = true; save() } )
                                    { Text("Save") }
                        }
                     
                        if UIDevice.current.userInterfaceIdiom == .mac  {
                            Button(action: Mac().macEmojiSelector )
                                { Text("Emoji") }
                        }
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        if UIDevice.current.userInterfaceIdiom == .mac || UIDevice.current.userInterfaceIdiom == .pad {
                            Picker(String(), selection: $selectedTemplate) {
                                ForEach(Global.templateIds, id: \.self) {
                                    geometry.size.width == smallestWidth ? Text(Global.template[$0].prefix(1)) : Text(Global.template[$0].prefix(6))
                                }
                                .font(.largeTitle)
                                .pickerStyle(SegmentedPickerStyle())
                            }
                        }
                    }
                    
                    ToolbarItemGroup(placement: .bottomBar) {
                        Picker(String(), selection: $selectedTemplate) {
                            ForEach(Global.templateIds, id: \.self) {
                                geometry.size.width == smallestWidth ? Text(Global.template[$0].prefix(1)) : Text(Global.template[$0].prefix(6))
                            }
                            .font(.largeTitle)
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                }
                .buttonStyle(SystemBlueButton())
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

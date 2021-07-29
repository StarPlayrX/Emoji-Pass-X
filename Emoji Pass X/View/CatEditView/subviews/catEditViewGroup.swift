//
//  catEditViewGroup.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

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
                
                .alert(isPresented: $security.isCatEditViewSaved, content: {
                    Alert(title: Text("Save"),
                          message: Text("Changes have been saved."),
                          dismissButton: .default(Text("OK")) { security.isCatEditViewSaved = false })
                })
                .onAppear(perform: {
                    catEditStruct.createNewCategory(listItem, security)
                })
                
                .onDisappear(perform: {catEditStruct.save(listItem,managedObjectContext,selectedTemplate)})
            }
        }
    }
}

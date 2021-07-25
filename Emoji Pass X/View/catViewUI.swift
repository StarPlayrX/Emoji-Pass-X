//
//  catViewUI.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension CatView {
    func catViewUI() -> some View {
        Group {
            
            catViewList()
                
            .alert(isPresented: $security.isValid, content: {
                Alert(title: Text("We're sorry."),
                      message: Text("This category cannot be deleted."),
                      dismissButton: .default(Text("OK")) {security.isValid = false})
            })
            .environment(\.editMode,
                         .constant(security.isEditing ? EditMode.active : EditMode.inactive))
            .animation(security.isEditing ? .easeInOut : .default)
            .navigationBarTitle("Categories", displayMode: .inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {security.catLock = !security.catLock; security.isEditing = false}){
                        security.catLock ? Image(systemName: "lock.fill") : Image(systemName: "lock.open")
                    }
                }

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {security.isEditing = !security.isEditing; security.catLock = true}){
                        security.isEditing ? Image(systemName: "hammer") : Image(systemName: "hammer.fill")
                    }

                    Button(action: addItem) { Image(systemName: "plus") }
                }
            }
            .buttonStyle(SystemBlueButton())
        }
    }
}

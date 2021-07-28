//
//  catViewUI.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension CatView {
    
    func stop() {
        security.haltAnimations = true
        security.catLock = !security.catLock
        security.isEditing = false
    }
    
    func start() {
        security.haltAnimations = false
        security.isEditing = !security.isEditing
        security.catLock = true
    }
    
    func catViewUI(detailListItems: FetchedResults<ListItem>) -> some View {
        Group {
            catViewList(detailListItems: detailListItems)
            .alert(isPresented: $security.isValid, content: {
                Alert(title: Text("We're sorry."),
                      message: Text("This category cannot be deleted."),
                      dismissButton: .default(Text("OK")) {security.isValid = false})
            })
            .environment(\.editMode,
                         .constant(security.isEditing ? EditMode.active : EditMode.inactive))
            .navigationBarTitle("Categories", displayMode: .inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: stop) {
                        security.catLock ? Image(systemName: "lock.fill") : Image(systemName: "lock.open")
                    }
                }

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: start) {
                        security.isEditing ? Image(systemName: "hammer") : Image(systemName: "hammer.fill")
                    }
                    Button(action: {catStruct.addItem(managedObjectContext, listItems)}) { Image(systemName: "plus") }
                }
            }
            .animation(security.haltAnimations ? .none : .easeInOut)
            .buttonStyle(SystemBlueButton())
        }
    }
}

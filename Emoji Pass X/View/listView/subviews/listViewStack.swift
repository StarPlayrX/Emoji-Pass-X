//
//  listView_.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ListView {
    
    func listViewStack() -> some View {
        VStack {
            List {
                listViewSearchBar()
                repeatView(detailListItems)
            }
            .padding(.leading, Device().iPhoneXLeading())
            .listStyle(PlainListStyle())
        }
        .navigationBarTitle(catItem.name, displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: { security.isEditing = !security.isEditing  })
                    { security.isEditing ? Image(systemName: "hammer") : Image(systemName: "hammer.fill") }
                canCreate()
            }
        }
        .buttonStyle(SystemBlueButton())
        
        
        .alert(isPresented: $security.isDeleteListViewValid, content: {
            Alert(title: Text("We're sorry."),
                  message: Text("This item is locked and cannot be deleted."),
                  dismissButton: .default(Text("OK")) { security.isDeleteListViewValid = false })
        })
    }
}

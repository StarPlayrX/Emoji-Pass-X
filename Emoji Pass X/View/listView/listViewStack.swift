//
//  listView_.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
//

import SwiftUI

extension ListView {
    
    func listViewStack() -> some View {
        VStack {
            List {
                searchStack()
                forEach(detailListItems)
            }
            .padding(.leading, iPhoneXLeading())
            .listStyle(PlainListStyle())
        }
        
        .navigationBarTitle(catItem.name, displayMode: .inline)
        .toolbar {
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {  security.isEditing = !security.isEditing  })
                {
                    if security.isEditing  {
                        Image(systemName: "hammer")
                    } else {
                        Image(systemName: "hammer.fill")
                    }
                }
                canCreate()
            }
        }
        .alert(isPresented: $security.isDeleteListViewValid, content: {
            Alert(title: Text("We're sorry."),
                  message: Text("This item is locked and cannot be deleted."),
                  dismissButton: .default(Text("OK")) { security.isDeleteListViewValid = false })
        })
    }
    
}

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
            
            //MARK: To do - please clean this up
            ToolbarItemGroup(placement: .bottomBar) {
                
                if UIDevice.current.userInterfaceIdiom == .pad {
                    Spacer()
                    Button(action: { saveItems();security.isEditing = false;security.isListItemViewSaved = true; })
                        { Text("Save") }
                        .alert(isPresented: $security.isListItemViewSaved, content: {
                            Alert(title: Text("Save"),
                                  message: Text("Items have been saved."),
                                  dismissButton: .default(Text("OK")) { security.isListItemViewSaved = false })
                        })
                    Spacer()
                }
            }
            
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
    }
}

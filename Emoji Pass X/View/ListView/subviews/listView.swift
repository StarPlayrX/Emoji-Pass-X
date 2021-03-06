//
//  listView.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ListView {
    func listView(detailListItems: FetchedResults<ListItem>) -> some View {
        ZStack {
            listViewUI()
        }
        .environment(\.editMode, .constant(security.isEditing ? EditMode.active : EditMode.inactive))
        .animation(security.isEditing ? .easeInOut : .default)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            DispatchQueue.main.async() {
                HideKeys().hideKeyboard()
                listStruct.saveItems(managedObjectContext) 
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

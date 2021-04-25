//
//  listViewDetailView.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
//

import SwiftUI


extension ListView {
    func detailListView() -> some View {
        ZStack {
            listViewStack()
            
        }
        .environment(\.editMode, .constant(security.isEditing ? EditMode.active : EditMode.inactive)).animation(security.isEditing ? .easeInOut : .none)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            DispatchQueue.main.async() {
                hideKeyboard()
                saveItems()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

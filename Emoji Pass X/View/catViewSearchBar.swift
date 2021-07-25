//
//  catViewSsearchBar.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

// https://www.youtube.com/watch?v=vgvbrBX2FnE (Search Bar How to Reference in SwiftUI)

extension CatView {
    func catViewSsearchBar() -> some View {
        return HStack {
            TextField("Search", text: $searchText)
                .padding(.leading, Device().iPhoneXSearch())
                .padding(.trailing, 64)
                .listRowBackground(Color(UIColor.systemBackground))
                .textContentType(.nickname)
                .keyboardType(.alphabet)
        }
        .listRowBackground(Color(UIColor.systemBackground))
        .padding(.leading, 8)
        
        .onTapGesture( perform: {
            isSearching = true
        })
        .overlay (
            HStack {
                Image(systemName: "magnifyingglass")
                    .padding(.leading, Device().iPhoneXMag())
                Spacer()
                    .padding(.trailing, 16)
                if isSearching {
                    Button(action: {searchText = String(); hideKeyboard()}, label: {
                        Image(systemName: "xmark")
                            .padding(.vertical)
                            .padding(.trailing, 2)
                    })
                    .buttonStyle(SystemWhiteButton())
                }
            }
        )
    }
}

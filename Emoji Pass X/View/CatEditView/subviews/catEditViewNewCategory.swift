//
//  catEditViewNewCategory.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/25/21.
//

import SwiftUI

extension CatEditView {
    func catEditViewNewCategory() -> some View {
        VStack {
            if listItem.uuidString != "Stars" {
                HStack {
                    Button(action: Stars )
                        { Text("Create an All Stars Category") }
                        .padding(.top, 20)
                        .padding(.leading, 12)
                    Spacer()
                }
            }
            
            if listItem.uuidString != "Everything" {
                HStack {
                    Button(action: Everything )
                        { Text("Create a Flashlight Category") }
                        .padding(.top, 20)
                        .padding(.leading, 12)
                    Spacer()
                }
            }
        }
    }
}

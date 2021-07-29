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
            if listItem.uuidString != CategoryType.stars.rawValue  {
                HStack {
                    Button(action: {catEditStruct.Stars(listItem, security)})
                        {Text("Create an All Stars Category")}
                        .padding(.top, 20)
                        .padding(.leading, 12)
                    Spacer()
                }
            }
            
            if listItem.uuidString != CategoryType.everything.rawValue  {
                HStack {
                    Button(action: {catEditStruct.Everything(listItem, security)})
                        {Text("Create a Flashlight Category")}
                        .padding(.top, 20)
                        .padding(.leading, 12)
                    Spacer()
                }
            }
        }
    }
}

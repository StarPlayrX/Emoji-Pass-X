//
//  catEditViewDefaultTemplate.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/25/21.
//

import SwiftUI

extension CatEditView {
    func catEditViewDefaultTemplate() -> some View {
        HStack {
            Text("Default template: \(Global.template[selectedTemplate]).")
                .padding(.horizontal, horizontal + (margin * 1.5))
                .foregroundColor(Colors.secondary)
                .padding(.bottom, -32)
                .padding(.top, 16)
            Spacer()
        }
        .padding(.bottom, 20)
    }
}

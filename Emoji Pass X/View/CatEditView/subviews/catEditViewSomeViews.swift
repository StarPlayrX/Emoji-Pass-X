//
//  catEditViewLabel.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension CatEditView {
    
    func label(_ text: String) -> some View {
        HStack(spacing: spacing) {
            Text(text)
                .foregroundColor(Colors.secondary)
            Spacer()
        }
        .padding(.horizontal, horizontal)
        .padding(.bottom, bottom / 2)
        .padding(.leading, margin * 1.5)
        .padding(.trailing, margin * 1.5)
    }
    
    func stack(_ hideLabels: Bool) -> some View {
        VStack {
            //MARK: Description
            if !hideLabels { label(CategoryStrings.desc.rawValue) }
            
            field(CategoryStrings.desc.rawValue, item: $listItem.desc, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.organizationName)
        }
    }
    
    func field(_ text: String, item: Binding<String>, keyboard: UIKeyboardType, textContentType: UITextContentType ) -> some View {
        HStack(spacing: spacing) {
            TextField("\(CategoryStrings.enter.rawValue) \(text)", text: item)
                .textContentType(textContentType)
                .keyboardType(keyboard)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        .padding(.bottom, bottom)
        .padding(.horizontal, horizontal + (margin * 1.5))
    }
}

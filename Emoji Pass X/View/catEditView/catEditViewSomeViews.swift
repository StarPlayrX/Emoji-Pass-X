//
//  catEditViewLabel.swift
//  Emoji Pass X
//
//  Created by M1 on 3/27/21.
//

import SwiftUI

extension CatEditView {
    
    func label(_ text: String) -> some View {
        HStack(spacing: spacing) {
            Text(text)
                .foregroundColor(labelColor)
            Spacer()
        }
        .padding(.horizontal, horizontal)
        .padding(.bottom, bottom / 2)
        .padding(.leading, margin * 1.5)
        .padding(.trailing, margin * 1.5)
    }
    
    
    func stack(_ hideLabels: Bool) -> some View {
        VStack() {
            //MARK: Description
            if !hideLabels { label(desc) }
            
            field(desc, item: $listItem.desc, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.organizationName)
        }
    }
    
    
    func field(_ text: String, item: Binding<String>, keyboard: UIKeyboardType, textContentType: UITextContentType  ) -> some View {
        
        HStack(spacing: spacing) {
            TextField("\(enter) \(text)", text: item)
                .textContentType(textContentType)
                .keyboardType(keyboard)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        .padding(.horizontal, horizontal)
        .padding(.bottom, bottom)
        .padding(.leading, margin * 1.5)
        .padding(.trailing, margin * 1.5)
    }
    
}

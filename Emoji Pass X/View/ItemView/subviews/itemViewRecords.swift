//
//  itemViewRecords.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/24/21.
//
import SwiftUI

extension ItemView {

    func label(_ text: String) -> some View {
        HStack(spacing: spacing) {
            Text(text)
                .foregroundColor(Colors.secondary)
            Spacer()
        }
        .padding(.bottom, bottom / 2)
        .padding(.horizontal, horizontal + (margin * 1.5))
    }

    func formField(_ label: String,
                   boundText: Binding<String>,
                   keyboard: UIKeyboardType,
                   textContentType: UITextContentType,
                   action: @escaping () -> Void ) -> some View {
        Group {
            HStack(spacing: spacing) {
                if listItem.lock {
                    SecureField("\(enter) \(label)", text: boundText)
                        .textContentType(textContentType)
                        .allowsHitTesting(!listItem.lock)
                } else {
                    TextField("\(enter) \(label)", text: boundText)
                        .textContentType(textContentType)
                        .keyboardType(keyboard)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                }
                Button(action: action) {Image(systemName: clipBoard)}
                    .padding(.horizontal, clipPadding)
                    .buttonStyle(SystemBlueButton())
            }
            .padding(.bottom, bottom)
            .padding(.horizontal, horizontal + (margin * 1.5))
        }
    }
}

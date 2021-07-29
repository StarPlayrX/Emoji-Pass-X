//
//  itemViewHeader.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/24/21.
//
import SwiftUI
import Combine

extension ItemView {
    func itemViewHeader(_ geometry: GeometryProxy) -> some View {
        HStack {
            TextField(ItemStrings.emoji.rawValue, text: $listItem.emoji)
                .simultaneousGesture(TapGesture().onEnded {
                    Mac().macEmojiSelector()
                })
                .background(Colors.systemGray3)
                .cornerRadius(radius)
                .fixedSize(horizontal: false, vertical: true)
                .onReceive(Just(prevEmoji)) { _ in prevEmoji = LimitEmoji().limitText(Int(uno), listItem, prevEmoji)}
                .font(.system(size: geometry.size.width == smallestWidth ? emojiFontSize - ten : emojiFontSize))
                .minimumScaleFactor(uno)
                .multilineTextAlignment(.center)
                .frame(height: geometry.size.width == smallestWidth ? emojiFrameWidth - quarter : emojiFrameWidth )
                .frame(width: geometry.size.width == smallestWidth ? emojiFrameWidth - half : emojiFrameWidth - quarter )
                .padding(.bottom, minus10)
                .padding(.horizontal, ten)

            TextField(name, text: $listItem.name)
                .font(.largeTitle)
                .padding(.bottom, minus20)
                .keyboardType(.asciiCapable)
                .minimumScaleFactor(point8)

            Spacer()
        }
    }
}

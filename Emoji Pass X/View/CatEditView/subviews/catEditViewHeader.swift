//
//  catEditViewHeader.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/25/21.
//
import SwiftUI
import Combine

extension CatEditView {
    func catEditViewHeader(_ geometry: GeometryProxy) -> some View {
        HStack {
            TextField(CategoryStrings.emoji.rawValue, text: $listItem.emoji)
                .simultaneousGesture(TapGesture().onEnded {
                    Mac().macEmojiSelector()
                })
                .background(Colors.systemGray3)
                .cornerRadius(radius)
                .fixedSize(horizontal: false, vertical: true)
                .onReceive(Just(prevEmoji)) { _ in prevEmoji = LimitEmoji().limitText(1, listItem, prevEmoji)}
                .font(.system(size: geometry.size.width == smallestWidth ? emojiFontSize - 10 : emojiFontSize))
                .minimumScaleFactor(1)
                .multilineTextAlignment(.center)
                .frame(height: geometry.size.width == smallestWidth ? emojiFrameWidth - 25 : emojiFrameWidth )
                .frame(width: geometry.size.width == smallestWidth ? emojiFrameWidth - 50 : emojiFrameWidth - 25 )
                .padding(.bottom, -10)
                .padding(.horizontal, 10)
            
            TextField(CategoryStrings.name.rawValue, text: $listItem.name)
                .font(.largeTitle)
                .padding(.bottom, -20)
                .keyboardType(.asciiCapable)
                .minimumScaleFactor(0.8)
            
            Spacer()
        }
    }
}


//
//  SystemBlueButton.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/24/21.
//
import SwiftUI

// https://www.hackingwithswift.com/quick-start/swiftui/customizing-button-with-buttonstyle

struct SystemBlueButton: ButtonStyle {
    
    let highlightColor = Color(red: 64 / 255, green: ((128 + 192) / 2) / 255, blue: 255 / 255)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .foregroundColor(configuration.isPressed ? highlightColor : Color(.systemBlue))
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

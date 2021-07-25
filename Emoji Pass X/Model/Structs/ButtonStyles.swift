//
//  ButtonStyles.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/24/21.
//
import SwiftUI

// https://www.hackingwithswift.com/quick-start/swiftui/customizing-button-with-buttonstyle

struct SystemBlueButton: ButtonStyle {
    
    let highlightColor = Color(red: 0.25, green: 0.6275, blue: 1)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.25 : 1)
            .foregroundColor(configuration.isPressed ? highlightColor : Color(.systemBlue))
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct SystemWhiteButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.25 : 1)
            .foregroundColor(Color(.white))
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


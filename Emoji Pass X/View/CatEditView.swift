//
//  CatEditView.swift
//  Emoji Pass X
//
//  Created by StarPlayrX on 2/27/21.
//

import SwiftUI
import Combine

struct CatEditView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var security: Security

    @State var selectedTemplate = 1
    
    @ObservedObject var listItem: ListItem
    
    
    
    //strings
    let name = "Category Name"
    let emoji = ":)"
    let newRecord = "New Category"
    let textLimit = 1
    
    let pencil = "🐛"
    
    let userName = "Username"
    let passWord = "Password"
    let enter = "Enter"
    let copy = "Copy"
    let desc = "Description"
    let phone = "Phone"
    let pin = "Pin"
    let uuid = "UUID"
    let date = "Date"
    
    let labelColor = Color.secondary
    var labelColor2 = Color(UIColor.systemGray3)
    
    let margin = CGFloat(-20)
    let spacing = CGFloat(0)
    let radius = CGFloat(14)
    let bottom = CGFloat(10)
    let horizontal = CGFloat(40)
    let emojiFontSize = CGFloat(50)
    let emojiFrameWidth = CGFloat(100)
    let emojiPaddingBottom = CGFloat(30)
    let smallestWidth = CGFloat(320.0)
    
    let pasteboard = UIPasteboard.general
    
    //MARK: Body View
    var body: some View {
        
        catEditViewGroup()
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    save()
                    presentationMode.wrappedValue.dismiss()
                }
            }
    }
}

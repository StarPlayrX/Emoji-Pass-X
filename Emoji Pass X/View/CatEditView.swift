//
//  CatEditView.swift
//  Emoji Pass X
//
//  Created by StarPlayrX on 2/27/21.
//

import SwiftUI
import Combine

struct CatEditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @EnvironmentObject var security: Security
    
    @State var itemName: String = ""
    @State var itemEmoji: String = ""
    @State var itemDesc: String = ""
    @State var itemUUID: String = ""
    
    @ObservedObject var listItem: ListItem
    
    //Function to keep text length in limits
    func limitText(_ upper: Int) {
        if itemEmoji.count > upper {
            itemEmoji = String(itemEmoji.prefix(upper))
        }
    }
    
    //strings
    let name = "Category Name"
    let emoji = ":)"
    let newRecord = "New Category"
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
    
    func clearNewText() {

        //New Item detected, so we clear this out (otherwise fill it in!)
        if listItem.emoji == pencil && listItem.name == newRecord {
            itemName  = ""
            itemEmoji = ""
        } else {
            itemName = listItem.name
            itemEmoji = listItem.emoji
            itemDesc = listItem.desc
        }
        
        if !listItem.uuidString.isEmpty {
            itemUUID = listItem.uuidString
        }
    }
    
    let pasteboard = UIPasteboard.general
    
    func copyDesc() {
        pasteboard.string = itemDesc
    }
    
    func save() {
        //epoche date used to break cache and force a save
        listItem.dateString = String(Int(Date().timeIntervalSinceReferenceDate))
        if itemName.isEmpty {
            itemName = newRecord
        }
        
        if itemEmoji.isEmpty {
            itemEmoji = pencil
        }
        
        listItem.name       = itemName
        listItem.emoji      = itemEmoji
        listItem.desc       = itemDesc
        listItem.templateId = selectedTemplate
                
        if listItem.uuidString.isEmpty {
            listItem.uuidString = UUID().uuidString
        }
        
        DispatchQueue.main.async() {
            // do something
            if managedObjectContext.hasChanges {
                try? managedObjectContext.save()
            }
            
            hideKeyboard()
        }
    }
    
    let textLimit = 1
    
    private func label(_ text: String) -> some View {
        return HStack(spacing: spacing) {
            Text(text)
                .foregroundColor(labelColor)
            Spacer()
        }
        .padding(.horizontal, horizontal)
        .padding(.bottom, bottom / 2)
        .padding(.leading, margin * 1.5)
        .padding(.trailing, margin * 1.5)
    }
    
    private func field(_ text: String, item: Binding<String>, keyboard: UIKeyboardType, textContentType: UITextContentType  ) -> some View {
        
        return HStack(spacing: spacing) {
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
    
    private func stack(_ hideLabels: Bool) -> some View {
        return VStack() {
            //MARK: Description
            if !hideLabels { label(desc) }
            
            field(desc, item: $itemDesc, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.organizationName)
        }
    }
    
    @State private var selectedTemplate = 1
    
    //MARK: Body View
    var body: some View {
    
        GeometryReader { geometry in
            
            VStack {
                HStack() {
                    TextField(emoji, text: $itemEmoji)
                        .background(labelColor)
                        .cornerRadius(radius)
                        .fixedSize(horizontal: false, vertical: true)
                        .onReceive(Just(itemEmoji)) { _ in limitText(textLimit) }
                        .font(.system(size: geometry.size.width == smallestWidth ? emojiFontSize - 10 : emojiFontSize))
                        .minimumScaleFactor(1)
                        .multilineTextAlignment(.center)
                        .frame(height: geometry.size.width == smallestWidth ? emojiFrameWidth - 25 : emojiFrameWidth )
                        .frame(width: geometry.size.width == smallestWidth ? emojiFrameWidth - 50 : emojiFrameWidth - 25 )
                        .padding(.bottom, geometry.size.width == smallestWidth ? -10 : -10)
                        .padding(.leading, geometry.size.width == smallestWidth ? 10 : 10 )
                        .padding(.trailing, geometry.size.width == smallestWidth ? 10 : 10 )
                    TextField(name, text: $itemName)
                        .font(.largeTitle)
                        .padding(.bottom, geometry.size.width == smallestWidth ? -20 : -20)
                        .keyboardType(.asciiCapable)
                        .minimumScaleFactor(0.8)

                    Spacer()                    
                }
                
                if geometry.size.width == smallestWidth {
                    stack(true)
                } else {
                    stack(false)
                }
                
                if listItem.uuidString != "Stars" && listItem.uuidString != "Everything" {
                    VStack {
                        
                        HStack() {
                            Text("Default template: \(template[selectedTemplate]).")
                                .padding(.horizontal, horizontal)
                                .padding(.leading, margin * 1.5)
                                .padding(.trailing, margin * 1.5)
                                .foregroundColor(labelColor)
                                .padding(.bottom, -32)
                                .padding(.top, 16)
                            
                            Spacer()
                        }
                        Picker("Please select a template", selection: $selectedTemplate) {
                            ForEach(templateIds, id: \.self) {
                                Text(template[$0])
                            }.font(.title2)
                        }
                    }
                }
            }
            .onAppear(perform: {
                clearNewText()
            })
            
            .onDisappear(perform: { save() })
            
            .toolbar {
               /* ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                   /* Button(action: { save(); security.lockScreen = true })
                    {
                        Image(systemName: "lock.shield.fill")
                    }*/
                }*/
            }
            
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
}




//
//  itemViewMainView.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//
import SwiftUI
import Combine

extension ItemView {
    func itemViewDetailView() -> some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    HStack {
                        TextField(emoji, text: $listItem.emoji)
                            .background(labelColor2)
                            .cornerRadius(radius)
                            .fixedSize(horizontal: false, vertical: true)
                            .onReceive(Just(prevEmoji)) { _ in limitText() }
                            .font(.system(size: geometry.size.width == smallestWidth ? emojiFontSize - 10 : emojiFontSize))
                            .minimumScaleFactor(1)
                            .multilineTextAlignment(.center)
                            .frame(height: geometry.size.width == smallestWidth ? emojiFrameWidth - 25 : emojiFrameWidth )
                            .frame(width: geometry.size.width == smallestWidth ? emojiFrameWidth - 50 : emojiFrameWidth - 25 )
                            .padding(.bottom, -10)
                            .padding(.horizontal, 10)
                        TextField(name, text: $listItem.name)
                            .font(.largeTitle)
                            .padding(.bottom, -20)
                            .keyboardType(.asciiCapable)
                            .minimumScaleFactor(0.8)
                        Spacer()
                    }
                    //MARK: template = {0: "💳 Cards", 1: "🔒 Passwords", 2: "🔑 Keys"}
                    switch listItem.templateId {
                    case 0:
                        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .mac {
                            geometry.size.height <= 512 ? creditCardStack(true) : creditCardStack(false)
                        } else {
                            geometry.size.height <= 568 ? creditCardStack(!Device().isIPhoneX()) : creditCardStack(false)
                        }
                    case 1:
                        if UIDevice.current.userInterfaceIdiom == .pad ||  UIDevice.current.userInterfaceIdiom == .mac {
                            geometry.size.height <= 512 ? passwordStack(true) : passwordStack(false)
                        } else {
                            geometry.size.height <= 568 ? passwordStack(!Device().isIPhoneX()) : passwordStack(false)
                        }
                    case 2:
                        if UIDevice.current.userInterfaceIdiom == .pad ||  UIDevice.current.userInterfaceIdiom == .mac {
                            geometry.size.height <= 512 ? licenseKeyStack(true) : licenseKeyStack(false)
                        } else {
                            geometry.size.height <= 568 ? licenseKeyStack(!Device().isIPhoneX()) : licenseKeyStack(false)
                        }
                    default:
                        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .mac {
                            geometry.size.height <= 512 ? passwordStack(true) : passwordStack(false)
                        } else {
                            geometry.size.height <= 568 ? passwordStack(!Device().isIPhoneX()) : passwordStack(false)
                        }
                    }
                }
                .onDisappear(perform: {save(shouldHideKeyboard: true)} )
                .onAppear(perform: clearNewText )
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        if UIDevice.current.userInterfaceIdiom == .mac || UIDevice.current.userInterfaceIdiom == .pad {
                            Button(action: {security.isListItemViewSaved = true; save()}) {Text("Save")}
                        }
                        if UIDevice.current.userInterfaceIdiom == .mac {
                            Button(action: Mac().macEmojiSelector ) {Text("Emoji")}
                        }
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {listItem.lock = !listItem.lock;save()}){
                            listItem.lock ? Image(systemName: "lock.fill") : Image(systemName: "lock.open")
                        }
                        Button(action: {listItem.star = !listItem.star;save()}){
                            listItem.star ? Image(systemName: "star.fill") : Image(systemName: "star")
                        }
                    }
                    ToolbarItemGroup(placement: .bottomBar) {
                        Picker("", selection: $listItem.templateId) {
                            ForEach(templateIds, id: \.self) {
                                geometry.size.width == smallestWidth ? Text(template[$0].prefix(1)) : Text(template[$0].prefix(6))
                            }
                            .font(.largeTitle)
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                }
                .alert(isPresented: $security.isListItemViewSaved, content: {
                    Alert(title: Text("Save"),
                          message: Text("Your changes have been saved."),
                          dismissButton: .default(Text("OK")) { security.isListItemViewSaved = false })
                })
            } .navigationBarTitle( "Details", displayMode: .inline)
        }
        .onTapGesture {
            //hideKeyboard()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            //hideKeyboard()
            //save()
            //presentationMode.wrappedValue.dismiss()
        }
    }
}

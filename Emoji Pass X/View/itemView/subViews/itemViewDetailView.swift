//
//  itemViewMainView.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import SwiftUI

extension ItemView {
    
    func itemViewDetailView() -> some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    itemViewTextFieldStack()
                    
                    //MARK: let template = ["💳 Cards", "🔒 Passwords", "🔑 Keys"]
                    switch listItem.templateId {
                    case 0:
                        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .mac {
                            geometry.size.height <= 512 ? creditCardStack(true) : creditCardStack(false)
                        } else {
                            geometry.size.height <= 568 ? creditCardStack(!isIPhoneX()) : creditCardStack(false)
                        }
                    case 1:
                        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .mac {
                            geometry.size.height <= 512 ? passwordStack(true) : passwordStack(false)
                        } else {
                            geometry.size.height <= 568 ? passwordStack(!isIPhoneX()) : passwordStack(false)
                        }
                    case 2:
                        if UIDevice.current.userInterfaceIdiom == .pad ||  UIDevice.current.userInterfaceIdiom == .mac {
                            geometry.size.height <= 512 ? licenseKeyStack(true) : licenseKeyStack(false)
                        } else {
                            geometry.size.height <= 568 ? licenseKeyStack(!isIPhoneX()) : licenseKeyStack(false)
                        }
                    default:
                        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .mac {
                            geometry.size.height <= 512 ? passwordStack(true) : passwordStack(false)
                        } else {
                            geometry.size.height <= 568 ? passwordStack(!isIPhoneX()) : passwordStack(false)
                        }
                    }
                }
                .onDisappear(perform: {save(shouldHideKeyboard: true)} )
                .onAppear(perform: clearNewText )
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        if UIDevice.current.userInterfaceIdiom == .mac || UIDevice.current.userInterfaceIdiom == .pad {
                            Button(action: {security.isListItemViewSaved = true; save()} )
                                { Text("Save") }
                        }
                        if UIDevice.current.userInterfaceIdiom == .mac {
                            Button(action: macEmojiSelector )
                                { Text("Emoji") }
                        }
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: { listItem.lock = !listItem.lock;save() }) {
                            !listItem.lock ? Image(systemName: "lock.open") : Image(systemName: "lock.fill")
                        }
                        Button(action: { listItem.star = !listItem.star;save() }) {
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
            }
            .navigationBarTitle( "Details", displayMode: .inline)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            hideKeyboard()
            save()
            presentationMode.wrappedValue.dismiss()
        }
    }
}

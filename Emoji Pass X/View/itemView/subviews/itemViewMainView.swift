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
                    itemViewHeader(geometry: geometry)
                    itemViewMainBody(geometry: geometry)
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
                        Picker(String(), selection: $listItem.templateId) {
                            ForEach(Global.templateIds, id: \.self) {
                                geometry.size.width == smallestWidth ? Text(Global.template[$0].prefix(1)) : Text(Global.template[$0].prefix(6))
                            }
                            .font(.largeTitle)
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                }
                .padding(.leading, 20)
                .buttonStyle(SystemBlueButton())
                .alert(isPresented: $security.isListItemViewSaved, content: {
                    Alert(title: Text("Save"),
                          message: Text("Your changes have been saved."),
                          dismissButton: .default(Text("OK")) { security.isListItemViewSaved = false })
                })
            } .navigationBarTitle( "Details", displayMode: .inline)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            hideKeyboard()
            save()
            presentationMode.wrappedValue.dismiss()
        }
        .animation(.default)

    }
}

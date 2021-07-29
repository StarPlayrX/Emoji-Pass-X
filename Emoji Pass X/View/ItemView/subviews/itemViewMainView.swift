//
//  itemViewMainView.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//
import SwiftUI

extension ItemView {

    func save(_ shouldHideKeyBoard: Bool) {
        SaveItemStruct().save(shouldHideKeyBoard, record, privateKey, listItem, managedObjectContext)
    }

    func itemViewDetailView() -> some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    itemViewHeader(geometry)
                    itemViewMainBody(geometry)
                }
                .onDisappear(perform: {save(true)} )
                .onAppear(perform: {record = LoadItemStruct().load(privateKey, listItem, catItem, record)})
                .toolbar {

                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            Button(action: {security.isListItemViewSaved = true; save(false)}) {Text("Save")}
                                .buttonStyle(SystemBlueButton())

                        }
                    }

                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Group {
                            Button(action: {listItem.lock = !listItem.lock;save(false)}){
                                listItem.lock ? Image(systemName: "lock.fill") : Image(systemName: "lock.open")
                            }
                            Button(action: {listItem.star = !listItem.star;save(false)}){
                                listItem.star ? Image(systemName: "star.fill") : Image(systemName: "star")
                            }
                        }
                        .buttonStyle(SystemBlueButton())
                    }

                    ToolbarItemGroup(placement: .bottomBar) {
                        Picker(String(), selection: $selectedTemplate) {
                            ForEach(Global.templateIds, id: \.self) {
                                geometry.size.width == smallestWidth ? Text(Global.template[$0].prefix(1)) : Text(Global.template[$0].prefix(6))
                            }
                            .font(.largeTitle)
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                }
                .padding(.leading, twenty)
                .alert(isPresented: $security.isListItemViewSaved, content: {
                    Alert(title: Text("Save"),
                          message: Text("Your changes have been saved."),
                          dismissButton: .default(Text("OK")) {security.isListItemViewSaved = false})
                })
            } .navigationBarTitle( "Details", displayMode: .inline)
        }
        .onTapGesture {
            HideKeys().hideKeyboard()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            save(true)
            presentationMode.wrappedValue.dismiss()
        }
        .transition(.opacity)
        .animation(.none)
    }
}

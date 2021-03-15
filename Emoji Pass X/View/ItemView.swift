//
//  ListItemView.swift
//  Emoji Pass X
//
//  Created by StarPlayrX on 2/27/21.
//

import SwiftUI
import Combine

struct ItemView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    //@EnvironmentObject var security: Security
    @StateObject private var privateKey = privateParts()
     
    @ObservedObject var catItem: ListItem
    @ObservedObject var listItem: ListItem

    //MARK: New Password Items
    @State var pUsername: String = ""
    @State var pPassword: String = ""
    @State var pWebsite : String = ""
    @State var pPhone   : String = ""
    @State var pPin     : String = ""
    @State var pNotes   : String = ""

    //MARK: New Password Items
    @State var cBankname  : String = ""
    @State var cCardnumber: String = ""
    @State var cFullname  : String = ""
    @State var cCvc       : String = ""
    @State var cExpdate   : String = ""
    @State var cNotes     : String = ""

    //MARK: New License Key Items
    @State var kSoftwarepkg  : String = ""
    @State var kLicensekey   : String = ""
    @State var kEmailaddress : String = ""
    @State var kWebaddress   : String = ""
    @State var kSeats        : String = ""
    @State var kNotes        : String = ""

    //MARK: Function to keep text length in limits
    func limitText(_ upper: Int) {
        if listItem.emoji.count > upper {
            listItem.emoji = String(listItem.emoji.prefix(upper))
            hideKeyboard()
        }
    }
    
    //MARK: strings
    let name = "Name"
    let bank = "Bank Name"
    let emoji = ":)"
    let newRecord = "New Record"
    let pencil = "✏️"
    
    let clipBoard = "doc.on.clipboard"
    let clipPadding = CGFloat(5)
    
    let userName = "Username"
    let passWord = "Password"
    let enter = "Enter"
    let copy = "Copy"
    let desc = "Description"
    let web = "Website"
    let phone = "Phone"
    let pin = "Pin"
    let uuid = "UUID"
    let date = "Date"
    let card = "Card Number"
    let exp = "Expiration Date"
    let fullName = "Full Name"
    let cvc = "cvc"
    
    //Mark: Software Key Package
    let keypkg = "Software Package"
    let keylic = "License Key"
    let keyemail = "Email Address"
    let keyweb = "Software Web Address"
    let keyseats = "Number of Seats"
    
    let labelColor = Color.secondary
    var labelColor2 = Color(UIColor.systemGray3)
    var labelColor3 = Color(UIColor.systemGray)
    
    let margin = CGFloat(-20)
    let spacing = CGFloat(0)
    let radius = CGFloat(14)
    let bottom = CGFloat(10)
    let horizontal = CGFloat(40)
    let emojiFontSize = CGFloat(50)
    let emojiFrameWidth = CGFloat(100)
    let emojiPaddingBottom = CGFloat(30)
    let smallestWidth = CGFloat(320.0)
    
    private func createEncryptedKey(emojiKey: String) -> Data {
        let encryptedKey = encryptData(string: emojiKey, key: privateKey.parentKey)
        return encryptedKey
    }

    private func decryptEncryptedKey(emojiData: Data) -> String {
        let decryptedKey = decryptData(data: emojiData, key: privateKey.parentKey)
        return decryptedKey
    }

    private func clearNewText() {
        privateKey.parentKey = emojiParentKey()
        
        //New Item detected, so we clear this out (otherwise fill it in!)
        if ( listItem.emoji == pencil && listItem.name == newRecord ) {
            listItem.name  = ""
            listItem.emoji = ""
            listItem.templateId = catItem.templateId
            listItem.lock = false
            listItem.star = false
        }
        
        if listItem.uuidString.isEmpty {
            listItem.uuidString = catItem.uuidString
        }
        
        //MARK: Transition to new way
        if listItem.id.isEmpty {
            let emojiKey    = emojiRecordKey()
            let emojiData   = createEncryptedKey(emojiKey: emojiKey)
            privateKey.recordStr = decryptEncryptedKey(emojiData: emojiData)
            listItem.id  = emojiData
        } else {
            privateKey.recordStr = decryptEncryptedKey(emojiData: listItem.id)
            
            if privateKey.recordStr.isEmpty || privateKey.recordStr.count != 8 {
                let emojiKey    = emojiRecordKey()
                let emojiData   = createEncryptedKey(emojiKey: emojiKey)
                
                listItem.id  = emojiData
            }
        }
        
        //decrypted Key
        privateKey.recordKey = decryptEncryptedKey(emojiData: listItem.id).data
        
        pUsername = decryptData(data: listItem.pUsername, key: privateKey.recordKey)
        pPassword = decryptData(data: listItem.pPassword, key: privateKey.recordKey)
        pWebsite  = decryptData(data: listItem.pWebsite, key: privateKey.recordKey)
        pPhone    = decryptData(data: listItem.pPhone, key: privateKey.recordKey)
        pPin      = decryptData(data: listItem.pPin, key: privateKey.recordKey)
        pNotes      = decryptData(data: listItem.pNotes, key: privateKey.recordKey)

        cBankname   = decryptData(data: listItem.cBankname, key: privateKey.recordKey)
        cCardnumber = decryptData(data: listItem.cCardnumber, key: privateKey.recordKey)
        cFullname   = decryptData(data: listItem.cFullname, key: privateKey.recordKey)
        cCvc        = decryptData(data: listItem.cCvc, key: privateKey.recordKey)
        cExpdate    = decryptData(data: listItem.cExpdate, key: privateKey.recordKey)
        cNotes      = decryptData(data: listItem.cNotes, key: privateKey.recordKey)

        kSoftwarepkg  = decryptData(data: listItem.kSoftwarepkg, key: privateKey.recordKey)
        kLicensekey   = decryptData(data: listItem.kLicensekey, key: privateKey.recordKey)
        kEmailaddress = decryptData(data: listItem.kEmailaddress, key: privateKey.recordKey)
        kWebaddress   = decryptData(data: listItem.kWebaddress, key: privateKey.recordKey)
        kSeats        = decryptData(data: listItem.kSeats, key: privateKey.recordKey)
        kNotes        = decryptData(data: listItem.kNotes, key: privateKey.recordKey)

    }
    
    let pasteboard = UIPasteboard.general
    
    func copyPnotes() {
        pasteboard.string = pNotes
        hideKeyboard()
    }
    
    func copyKnotes() {
        pasteboard.string = kNotes
        hideKeyboard()
    }
    
    func copyCnotes() {
        pasteboard.string = cNotes
        hideKeyboard()
    }
    
    func copyUsername() {
        pasteboard.string = pUsername
        hideKeyboard()
    }
    
    func copyPass() {
        pasteboard.string = pPassword
        hideKeyboard()
    }
    
    func copyWeb() {
        pasteboard.string = pWebsite
        hideKeyboard()
    }
    
    func copyPhone() {
        pasteboard.string = pPhone
        hideKeyboard()
    }
    
    func copyPin() {
        pasteboard.string = pPin
        hideKeyboard()
    }
    
    func copyCard() {
        pasteboard.string = cCardnumber
        hideKeyboard()
    }
    
    func copyExp() {
        pasteboard.string = cExpdate
        hideKeyboard()
    }
    
    func copyFullName() {
        pasteboard.string = cFullname
        hideKeyboard()
    }
    
    func copyCVC() {
        pasteboard.string = cCvc
        hideKeyboard()
    }
    
    func copyBank() {
        pasteboard.string = cBankname
        hideKeyboard()
    }
    
    func copyKeylic() {
        pasteboard.string = kLicensekey
        hideKeyboard()
    }
    
    func copyKeypkg() {
        pasteboard.string = kSoftwarepkg
        hideKeyboard()
    }
    
    func copyKeyemail() {
        pasteboard.string = kEmailaddress
        hideKeyboard()
    }
    
    func copyKeyweb() {
        pasteboard.string = kWebaddress
        hideKeyboard()
    }
    
    func copyKeyseats() {
        pasteboard.string = kSeats
        hideKeyboard()
    }
    
    
    func save() {
        //epoche date used to break cache and force a save
        listItem.dateString = String(Int(Date().timeIntervalSinceReferenceDate))
        
        //MARK: Save Encrypted Strings
        listItem.pUsername = encryptData(string: pUsername, key: privateKey.recordKey)
        listItem.pPassword = encryptData(string: pPassword, key: privateKey.recordKey)
        listItem.pWebsite  = encryptData(string: pWebsite, key: privateKey.recordKey)
        listItem.pPhone    = encryptData(string: pPhone, key: privateKey.recordKey)
        listItem.pPin      = encryptData(string: pPin, key: privateKey.recordKey)
        listItem.pNotes      = encryptData(string: pNotes, key: privateKey.recordKey)

        listItem.cBankname   = encryptData(string: cBankname, key: privateKey.recordKey)
        listItem.cCardnumber = encryptData(string: cCardnumber, key: privateKey.recordKey)
        listItem.cFullname   = encryptData(string: cFullname, key: privateKey.recordKey)
        listItem.cCvc        = encryptData(string: cCvc, key: privateKey.recordKey)
        listItem.cExpdate    = encryptData(string: cExpdate, key: privateKey.recordKey)
        listItem.cNotes      = encryptData(string: cNotes, key: privateKey.recordKey)

        listItem.kSoftwarepkg  = encryptData(string: kSoftwarepkg, key: privateKey.recordKey)
        listItem.kLicensekey   = encryptData(string: kLicensekey, key: privateKey.recordKey)
        listItem.kEmailaddress = encryptData(string: kEmailaddress, key: privateKey.recordKey)
        listItem.kWebaddress   = encryptData(string: kWebaddress, key: privateKey.recordKey)
        listItem.kSeats        = encryptData(string: kSeats, key: privateKey.recordKey)
        listItem.kNotes        = encryptData(string: kNotes, key: privateKey.recordKey)

        
        DispatchQueue.main.async() {
            if managedObjectContext.hasChanges {
                try? managedObjectContext.save()
            }
            
            hideKeyboard()
            listItem.dateString = String(Int(Date().timeIntervalSinceReferenceDate))
            listItem.name.isEmpty ? (listItem.name = newRecord) : (listItem.name = listItem.name)
            listItem.emoji.isEmpty ? (listItem.emoji = pencil) : ( listItem.emoji = listItem.emoji)
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
    
    private func notesLabel(_ text: String) -> some View {
        return HStack(spacing: spacing) {
            Text("Notes")
                .foregroundColor(labelColor)
            Spacer()
            
            if text == "pNotes" {
                Button(action: copyPnotes) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == "cNotes" {
                Button(action: copyPass) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == "kNotes" {
                Button(action: copyPhone) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            }
            
        }
        .padding(.horizontal, horizontal)
        .padding(.bottom, 0)
        .padding(.leading, margin * 1.5)
        .padding(.trailing, margin * 1.5)
    }
    
    private func notesEditor(_ text: String, note: Binding<String>, keyboard: UIKeyboardType, textContentType: UITextContentType, hideLabels: Bool) -> some View {
        return VStack(spacing: spacing) {

            VStack {
                notesLabel(text)
                if !listItem.lock {

                    TextEditor(text: note)
                        .lineSpacing(3)
                        .multilineTextAlignment(.leading)
                        .textContentType(textContentType)
                        .keyboardType(keyboard)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                        .font(.body)
                        .padding(.top, 4)
                        .padding(.bottom, 4)
                        .padding(.leading, 9)
                        .padding(.trailing, 7)
                        .frame(minHeight: 45, maxHeight: 450, alignment: Alignment.topLeading )

                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(labelColor3, lineWidth: 1)
                        )
                        .padding()
                        .padding(.leading, -4)

                } else {
                    SecureField("",text: note)
                        .textContentType(textContentType)
                        .multilineTextAlignment(.leading)
                        .allowsHitTesting(!listItem.lock)
                        .padding(.top, 7)
                        .padding(.bottom, 1)
                        .padding(.leading, 9)
                        .padding(.trailing, 7)
                        .frame(minHeight: 36, maxHeight: 360, alignment: Alignment.topLeading )
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(labelColor3, lineWidth: 1)
                        )
                        .padding()
                        .padding(.leading, -4)
                }
            }
        }
    }
    
    private func field(_ text: String, item: Binding<String>, keyboard: UIKeyboardType, textContentType: UITextContentType) -> some View {
        
        return HStack(spacing: spacing) {
            
            if listItem.lock {
                SecureField("\(enter) \(text)", text: item)
                    .textContentType(textContentType)
                    .allowsHitTesting(!listItem.lock)
            } else {
                TextField("\(enter) \(text)", text: item)
                    .textContentType(textContentType)
                    .keyboardType(keyboard)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            
            //MARK: To do: Convert List to Switch Case
            if text == userName {
                Button(action: copyUsername) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == passWord {
                Button(action: copyPass) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == phone {
                Button(action: copyPhone) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == pin {
                Button(action: copyPin) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
                
            } else if text == web {
                Button(action: copyWeb) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
                
            } else if text == card {
                Button(action: copyCard) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
                
            } else if text == exp {
                Button(action: copyExp) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
                
            } else if text == fullName {
                Button(action: copyFullName) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
                
            } else if text == cvc {
                Button(action: copyCVC) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
            } else if text == bank {
                Button(action: copyBank) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
                
            } else if text == keypkg {
                Button(action: copyKeypkg) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
                
            } else if text == keylic {
                Button(action: copyKeylic) { Image(systemName: clipBoard) }
                    .padding(.horizontal, clipPadding)
                
            } else if text == keyemail {
                Button(action: copyKeyemail) { Image(systemName: clipBoard) }
                    .padding(.horizontal, 5.0)
                
            } else if text == keyseats {
                Button(action: copyKeyseats) { Image(systemName: clipBoard) }
                    .padding(.horizontal, 5.0)
                
            } else if text == keyweb {
                Button(action: copyKeyweb) { Image(systemName: clipBoard) }
                    .padding(.horizontal, 5.0)
                
            }
        }
        .padding(.horizontal, horizontal)
        .padding(.bottom, bottom)
        .padding(.leading, margin * 1.5)
        .padding(.trailing, margin * 1.5)
    }
    
    //MARK: Password Stack
    private func passwordStack(_ hideLabels: Bool) -> some View {

   
        return VStack() {
            Group {
                notesEditor("pNotes", note: $pNotes, keyboard: UIKeyboardType.alphabet, textContentType: UITextContentType.sublocality, hideLabels: hideLabels)
            }
            
            Group {
                //MARK: Username
                if !hideLabels { label(userName) }
                field(userName, item: $pUsername, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.username)
                
                //MARK: Password
                if !hideLabels {  label(passWord) }
                field(passWord, item: $pPassword, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.password)
                
                //MARK: Web
                if !hideLabels { label(web) }
                
                field(web, item: $pWebsite, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.URL)
                
                //MARK: Phone
                if !hideLabels { label(phone) }
                
                field(phone, item: $pPhone, keyboard: UIKeyboardType.numbersAndPunctuation, textContentType: UITextContentType.telephoneNumber)
                
                //MARK: Pin
                
                if !hideLabels { label(pin) }
                field(pin, item: $pPin, keyboard: UIKeyboardType.numbersAndPunctuation, textContentType: UITextContentType.oneTimeCode)
            }
            
            
        }
    }
    
    //MARK: CreditCardStack
    private func creditCardStack(_ hideLabels: Bool) -> some View {
        
        
        return VStack {
            Group {
                notesEditor("cNotes", note: $cNotes, keyboard: UIKeyboardType.alphabet, textContentType: UITextContentType.sublocality, hideLabels: hideLabels)
            }
            
            Group {
                if !hideLabels { label(bank) }
                field(bank, item: $cBankname, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.organizationName)
                
                if !hideLabels {  label(card) }
                field(card, item: $cCardnumber, keyboard: UIKeyboardType.numbersAndPunctuation, textContentType: UITextContentType.URL)
                
                if !hideLabels { label(fullName) }
                
                field(fullName, item: $cFullname, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.givenName)
                
                if !hideLabels { label(cvc) }
                
                field(cvc, item: $cCvc, keyboard: UIKeyboardType.numbersAndPunctuation, textContentType: UITextContentType.oneTimeCode)
                
                //MARK: Exp
                if !hideLabels { label(exp) }
                field(exp, item: $cExpdate, keyboard: UIKeyboardType.numbersAndPunctuation, textContentType: UITextContentType.nickname)
            }
        }
    }
    
    //MARK: licenseKeyStack
    private func licenseKeyStack(_ hideLabels: Bool) -> some View {
        

        return VStack {
            Group {
                notesEditor("kNotes", note: $kNotes, keyboard: UIKeyboardType.alphabet, textContentType: UITextContentType.sublocality, hideLabels: hideLabels)
            }
            
            Group {
                if !hideLabels { label(keypkg) }
                field(keypkg, item: $kSoftwarepkg, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.organizationName)
                
                if !hideLabels {  label(keylic) }
                field(keylic, item: $kLicensekey, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.givenName)
                
                if !hideLabels { label(keyemail) }
                
                field(keyemail, item: $kEmailaddress, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.emailAddress)
                
                if !hideLabels { label(keyweb) }
                
                field(keyweb, item: $kWebaddress, keyboard: UIKeyboardType.asciiCapable, textContentType: UITextContentType.URL)
                
                if !hideLabels { label(keyseats) }
                field(keyseats, item: $kSeats, keyboard: UIKeyboardType.numbersAndPunctuation, textContentType: UITextContentType.nickname)
            }
        }
    }
    
    
    var body: some View {
      
        GeometryReader { geometry in
            ScrollView {
                    VStack() {
                        HStack() {
                            TextField(emoji, text: $listItem.emoji)
                                .background(labelColor2)
                                .cornerRadius(radius)
                                .fixedSize(horizontal: false, vertical: true)
                                .onReceive(Just(listItem.emoji)) { _ in limitText(textLimit) }
                                .font(.system(size: geometry.size.width == smallestWidth ? emojiFontSize - 10 : emojiFontSize))
                                .minimumScaleFactor(1)
                                .multilineTextAlignment(.center)
                                .frame(height: geometry.size.width == smallestWidth ? emojiFrameWidth - 25 : emojiFrameWidth )
                                .frame(width: geometry.size.width == smallestWidth ? emojiFrameWidth - 50 : emojiFrameWidth - 25 )
                                .padding(.bottom, geometry.size.width == smallestWidth ? -10 : -10)
                                .padding(.leading, geometry.size.width == smallestWidth ? 10 : 10 )
                                .padding(.trailing, geometry.size.width == smallestWidth ? 10 : 10 )
                            TextField(name, text: $listItem.name)
                                .font(.largeTitle)
                                .padding(.bottom, geometry.size.width == smallestWidth ? -20 : -20)
                                .keyboardType(.asciiCapable)
                                .minimumScaleFactor(0.8)
                            Spacer()
                        }
                        //MARK: let template = ["💳 Cards", "🔒 Passwords", "🔑 Keys"]
                        
                     
                        
                        if listItem.templateId == 1  {
                            geometry.size.height <= 568 ? passwordStack(!isIPhoneX()) : passwordStack(false)
                        } else if listItem.templateId == 0  {
                            geometry.size.height <= 568 ? creditCardStack(!isIPhoneX()) : creditCardStack(false)
                        } else if listItem.templateId == 2  {
                            geometry.size.height <= 568 ? licenseKeyStack(!isIPhoneX()) : licenseKeyStack(false)
                        }
                    }
                    .onDisappear(perform: { save() })
                    .onAppear(perform: { clearNewText() })
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            
                            Button(action: { listItem.lock = !listItem.lock;save() })
                            {
                                if !listItem.lock {
                                    Image(systemName: "lock.open")
                                } else {
                                    Image(systemName: "lock.fill")
                                }
                            }
                            Button(action: { listItem.star = !listItem.star;save() })
                            {
                                if listItem.star {
                                    Image(systemName: "star.fill")
                                } else {
                                    Image(systemName: "star")
                                    
                                }
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
            } .navigationBarTitle( geometry.size.width <= 374 ? "Pass X" : "🛡 Emoji Pass X", displayMode: .inline)
        }

        .onTapGesture {
            hideKeyboard()
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            save()
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    //MARK: Private Parts
    private class privateParts: ObservableObject {
        @Published var parentKey = Data()
        @Published var recordKey = Data()
        @Published var recordStr = String()
    }
   
    //MARK: Consistently creates our MasterKey for the entire app
    private func emojiParentKey() -> Data {
        let a = 2
        let b = 1
        let d = Int(pool.count / 8) - a
        var c = pool.count - b
        
        var e = ""
        
        for _ in 1...8 {
            c -= d
            e += pool[c]
        }
        
        return e.data
    }

    //MARK: Random Emoji String used for each Record
    private func emojiRecordKey() -> String {
        var a = ""
        
        for _ in 1...8 {
            let b = Int.random(in: 0..<pool.count)
            a += pool[b]
        }
        
        return a
    }
}

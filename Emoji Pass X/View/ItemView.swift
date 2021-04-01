//
//  ListItemView.swift
//  Emoji Pass X
//
//  Created by StarPlayrX on 2/27/21.
//

import SwiftUI
import Combine
import UIKit


struct ItemView: View {

    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var security: Security
    @StateObject var privateKey = privateParts()

    @ObservedObject var catItem: ListItem
    @ObservedObject var listItem: ListItem

    @State var prevEmoji  : String = ""

    
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

    //MARK: strings
    let name = "Name"
    let bank = "Bank Name"
    let emoji = ":)"
    let newRecord = "New Record"
    let pencil = "✏️"
    
    let textLimit = 1
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
    
    let pasteboard = UIPasteboard.general

    var body: some View {
        ItemViewDetailView()
            .onAppear(perform: {prevEmoji = listItem.emoji})
    }
}

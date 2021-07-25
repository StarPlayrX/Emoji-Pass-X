//
//  ListItemView.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 2/27/21.
//

import SwiftUI
import UIKit

struct ItemView: View {
    // CoreData + CloudKit
    @Environment(\.managedObjectContext) var managedObjectContext

    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var security: Security
    @StateObject var privateKey = privateParts()
    @ObservedObject var catItem: ListItem
    @ObservedObject var listItem: ListItem

    @State var prevEmoji : String = String()

    //MARK: New Password Items
    @State var pUsername: String = String()
    @State var pPassword: String = String()
    @State var pWebsite : String = String()
    @State var pPhone   : String = String()
    @State var pPin     : String = String()
    @State var pNotes   : String = String()

    //MARK: New Password Items
    @State var cBankname  : String = String()
    @State var cCardnumber: String = String()
    @State var cFullname  : String = String()
    @State var cCvc       : String = String()
    @State var cExpdate   : String = String()
    @State var cNotes     : String = String()

    //MARK: New License Key Items
    @State var kSoftwarepkg  : String = String()
    @State var kLicensekey   : String = String()
    @State var kEmailaddress : String = String()
    @State var kWebaddress   : String = String()
    @State var kSeats        : String = String()
    @State var kNotes        : String = String()

    //MARK: Constants
    let emoji = ":)"
    let newRecord = "New Record"
    let uuid = "UUID"
    let pencil = "✏️"
    let textLimit = 1
    let clipBoard = "doc.on.clipboard"
    let clipPadding = CGFloat(5)
    let name = "Name"
    let bank = "Bank Name"
    let userName = "Username"
    let passWord = "Password"
    let enter = "Enter"
    let copy = "Copy"
    let desc = "Description"
    let web = "Website"
    let phone = "Phone"
    let pin = "Pin"
    let date = "Date"
    let card = "Card Number"
    let exp = "Expiration Date"
    let fullName = "Full Name"
    let cvc = "cvc"
    let keypkg = "Software Package"
    let keylic = "License Key"
    let keyemail = "Email Address"
    let keyweb = "Software Web Address"
    let keyseats = "Number of Seats"
    let labelColor = Color.secondary
    let margin = CGFloat(-20)
    let spacing = CGFloat(0)
    let radius = CGFloat(14)
    let bottom = CGFloat(10)
    let horizontal = CGFloat(40)
    let emojiFontSize = CGFloat(50)
    let emojiFrameWidth = CGFloat(100)
    let emojiPaddingBottom = CGFloat(30)
    let smallestWidth = CGFloat(320.0)
    let labelColor2 = Color(UIColor.systemGray3)
    let labelColor3 = Color(UIColor.systemGray)

    var body: some View {
        itemViewDetailView()
    }
}

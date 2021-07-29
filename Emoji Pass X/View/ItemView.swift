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
    @StateObject var privateKey = PrivateKeys()
    @ObservedObject var catItem: ListItem
    @ObservedObject var listItem: ListItem

    @State var prevEmoji : String = String()
    @State var record = Record()

    @State var selectedTemplate = 1
    
    //MARK: Constants
    let name     = Labels.str.name
    let bank     = Labels.str.bank
    let userName = Labels.str.userName
    let passWord = Labels.str.passWord
    let enter    = Labels.str.enter
    let copy     = Labels.str.copy
    let desc     = Labels.str.desc
    let web      = Labels.str.web
    let phone    = Labels.str.phone
    let pin      = Labels.str.pin
    let date     = Labels.str.date
    let card     = Labels.str.card
    let exp      = Labels.str.exp
    let fullName = Labels.str.fullName
    let cvc      = Labels.str.cvc
    let keypkg   = Labels.str.keypkg
    let keylic   = Labels.str.keylic
    let keyemail = Labels.str.keyemail
    let keyweb   = Labels.str.keyweb
    let keyseats = Labels.str.keyseats

    let clipBoard   = Images.img.clipBoard
    let clipPadding = Floats.ui.clipPadding

    let margin             = Floats.ui.margin
    let spacing            = Floats.ui.spacing
    let radius             = Floats.ui.radius
    let bottom             = Floats.ui.bottom
    let horizontal         = Floats.ui.horizontal
    let emojiFontSize      = Floats.ui.emojiFontSize
    let emojiFrameWidth    = Floats.ui.emojiFrameWidth
    let emojiPaddingBottom = Floats.ui.emojiPaddingBottom
    let smallestWidth      = Floats.ui.smallestWidth

    var body: some View {
        itemViewDetailView()
    }
}

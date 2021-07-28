//
//  CatEditView.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 2/27/21.
//

import SwiftUI
import Combine

struct CatEditView: View {
    @Environment(\.presentationMode) var presentationMode
    
    //CoreData + CloudKit
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @EnvironmentObject var security: Security
    @ObservedObject var listItem: ListItem
    
    @State var prevEmoji = String()
    @State var selectedTemplate = 1

    let catEditStruct = CatEditStruct()

    let labelColor = Color.secondary
    var labelColor2 = Color(UIColor.systemGray3)
    
    let textLimit = 1
    let margin = CGFloat(-20)
    let spacing = CGFloat(0)
    let radius = CGFloat(14)
    let bottom = CGFloat(10)
    let horizontal = CGFloat(40)
    let emojiFontSize = CGFloat(50)
    let emojiFrameWidth = CGFloat(100)
    let emojiPaddingBottom = CGFloat(30)
    let smallestWidth = CGFloat(320)
        
    //MARK: Body View
    var body: some View {
        catEditViewGroup()
    }
}

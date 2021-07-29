//
//  CatEditView.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 2/27/21.
//

import SwiftUI

struct CatEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @EnvironmentObject var security: Security
    @ObservedObject var listItem: ListItem
    
    @State var prevEmoji = String()
    @State var selectedTemplate = 1

    let catEditStruct = CatEditStruct()
    
    let margin             = Floats.ui.margin
    let spacing            = Floats.ui.spacing
    let radius             = Floats.ui.radius
    let bottom             = Floats.ui.bottom
    let horizontal         = Floats.ui.horizontal
    let emojiFontSize      = Floats.ui.emojiFontSize
    let emojiFrameWidth    = Floats.ui.emojiFrameWidth
    let emojiPaddingBottom = Floats.ui.emojiPaddingBottom
    let smallestWidth      = Floats.ui.smallestWidth
        
    //MARK: Body View
    var body: some View {
        catEditViewGroup()
    }
}

//
//  itemViewFunctions.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 3/27/21.
//

import Foundation

extension ItemView {
    
    //MARK: Function to keep text length in limits
    func limitText(_ charLimit : Int = 1 ) {
        if listItem.emoji.count > charLimit {
            let usePrefix = prevEmoji == listItem.emoji.suffix(charLimit)
            listItem.emoji = String( usePrefix ? listItem.emoji.prefix(charLimit) : listItem.emoji.suffix(charLimit) )
        }
        prevEmoji = listItem.emoji
    }
}

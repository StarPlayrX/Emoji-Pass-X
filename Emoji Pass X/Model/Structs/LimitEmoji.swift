//
//  LimitEmoji.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/27/21.
//

import Foundation

struct LimitEmoji {
    func limitText(_ charLimit : Int = 1,_ listItem: ListItem,_ prevEmoji: String ) -> String {
        if listItem.emoji.count > charLimit {
            let usePrefix = prevEmoji == listItem.emoji.suffix(charLimit)
            listItem.emoji = String( usePrefix ? listItem.emoji.prefix(charLimit) : listItem.emoji.suffix(charLimit) )
        }
        return listItem.emoji
    }

}

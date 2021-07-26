//
//  ListView.swift
//  Emoji Pass
//
//  Created by Todd Bruss on 11/15/20.
//

import SwiftUI
import Combine

struct ListView: View {
    
    @State var myKeys = Array(gSafe.keys)
    @State var isTapped = false
    
    var body: some View {

        List {
            ForEach(myKeys.sorted(), id: \.self) { key in
                
                NavigationLink(
                    destination: EmojiTF(key:key),
                    label: {
                        Text(key)
                    })
                    .font(.largeTitle)
            }

        }.navigationBarTitle("Emoji List X", displayMode: .inline)
        .onAppear( perform: startup )
    }
     
    func shutdown() {
        let pencil = "✏️"
        if myKeys.first == pencil {
            myKeys.remove(at: 0)
        }
    }
    
     func startup() {
        myKeys = Array(gSafe.keys)
        
        let pencil = "✏️"
        if myKeys.first != pencil {
            myKeys.insert(pencil,at: 0)
        }
    }
}


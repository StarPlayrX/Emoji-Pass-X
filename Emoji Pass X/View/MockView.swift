//
//  MockView.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/27/21.
//

import SwiftUI


var mockView: some View {
    Group {
        VStack {
            Text("Emoji Pass X").font(.largeTitle).minimumScaleFactor(0.75).padding(.top, 50)

            HStack {
                Image("Emoji Pass X_logo4")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 230.0, height: 230)
                    .background(Color.clear)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 48)
                    .stroke(Color.gray, lineWidth: 2)
            )

            Text("© 2021 Todd Bruss").font(.callout).minimumScaleFactor(0.75).padding(.top, 10)
                .padding(.bottom, 25)
            Button("Continue") {}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        mockView
    }
}


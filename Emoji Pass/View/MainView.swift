//
//  MainView.swift
//  Emoji Pass
//
//  Created by Todd Bruss on 11/14/20.
//

import SwiftUI
import Combine

public extension UITextField {
    override var textInputMode: UITextInputMode? {
        return UITextInputMode.activeInputModes.filter { $0.primaryLanguage == "emoji" }.first ?? super.textInputMode
    }
}

struct MainView: View {
    @State var masterKey: String
    
    @State var xxx = ""
    @State var emojiText = ""
    let textLimit = 4 //Your limit
    
    //Function to keep text length in limits
    func limitText(_ upper: Int) {
        if emojiText.count > upper {
            emojiText = String(emojiText.prefix(upper))
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                NavigationView {
                    
                    VStack(spacing:0) {
                        
                        Text("Master Key")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .keyboardType(.default)
                            .padding(.bottom, geometry.size.width == 320.0 ? 10 : 30)
                            .padding(.top, 30)
                        
                        TextField("", text: $emojiText)
                            .background(Color.gray)
                            .cornerRadius(14)
                            .onReceive(Just(emojiText)) { _ in limitText(textLimit) }
                            .font(.system(size: geometry.size.width == 320.0 ? 55 : 65))
                            .minimumScaleFactor(0.01)
                            .multilineTextAlignment(.center)
                            .frame( width: geometry.size.width == 320.0 ? 255 : 300, height:70 )
                            .fixedSize(horizontal: true, vertical: true)
                        
                        Button(action: { saveMaster(_: geometry.size.width) } ) {
                            Text("Save Master Key\r\nMake this memorable")
                        }
                        .multilineTextAlignment(.center)
                        .disabled(emojiText.count < 4 && masterKey.count == 0  )
                        .opacity(checkMaster() ? 0 : 1)
                        .padding(.top, geometry.size.width == 320.0 ? 10 : 30)
                        .isHidden(checkMaster() ? true : false, remove: checkMaster() ? true : false)
                        
                        NavigationLink(destination: ListView() ) {
                            Text("Show Emoji List X")
                        }.navigationBarTitle("Emoji Pass X", displayMode: .inline)
                        
                        
                        .disabled(emojiText != masterKey || emojiText.count < 4 || masterKey.count < 4 )
                        .padding(.top, geometry.size.width == 320.0 ? 20 : 40)
                        .opacity(1.0)
                        
                        Text("© 2020 Todd Bruss")
                            .font(.system(size: geometry.size.width == 320.0 ? 14 : 16))
                            .padding(30)
                            .opacity(0.4)
                        Spacer()
                    }.frame(width: geometry.size.width)
                }
            }
        }
    }
    
    func saveMaster(_ g: CGFloat) {
        print(g)
        saveMasterKey(masterKey: emojiText)
        loadMaster()
        emojiText = masterKey
    }
    
    func loadMaster() {
        masterKey = loadMasterKey()
    }
    
    func checkMaster() -> Bool {
        if let master = UserDefaults.standard.string(forKey: "gMaster") {
            return master.count == 4
        }
        return false
    }
}

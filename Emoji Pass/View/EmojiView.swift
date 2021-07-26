import SwiftUI
import Combine

struct EmojiTF: View {
    
    @State var key: String
    @State var emojiText = ""
    @State var user = ""
    @State var pass = ""
    @State private var showingAlert = false
    
    let pencil = "✏️"
    let textLimit = 1
    
    //Function to keep text length in limits
    func limitText(_ upper: Int) {
        if emojiText.count > upper {
            emojiText = String(emojiText.prefix(upper))
        }
    }
    
    let pasteboard = UIPasteboard.general
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack() {
                
                VStack(spacing: 0) {
                    
                    Spacer()

                    HStack() {
                        
                        Button(action: fromScratch) {
                            Text("New")
                        }.padding(10)
                        
                        Spacer()
                        
                        Button(action: saveData) {
                            Text("Save")
                        }.padding(10)
                        .disabled(emojiText.count < 1 )
                        
                        Spacer()
                        
                        Button(action: {
                            self.showingAlert = true
                        }) {
                            Text("Delete")
                        }
                        .alert(isPresented:$showingAlert) {
                            Alert(title: Text("Are you sure you want to delete this entry?"), message: Text("There is no escape."), primaryButton: .destructive(Text("Delete")) {
                                gSafe[emojiText] = nil
                                fromScratch()
                                saveData()
                            }, secondaryButton: .cancel())
                        }
                        
                    }.padding(.horizontal, 40)
                    .padding(.bottom,  geometry.size.width == 320.0 ? 0 : 10)
                    .padding(.top,  geometry.size.width == 320.0 ? 0 : 10)

                    HStack() {
                        TextField("", text: $emojiText)
                            .background(Color.gray)
                            .cornerRadius(14)
                            
                            .padding(.leading, geometry.size.width == 320.0 ? 30 : 40 )
                            .fixedSize(horizontal: false, vertical: true)
                            .onReceive(Just(emojiText)) { _ in limitText(textLimit) }
                            .font(.system(size: geometry.size.width == 320.0 ? 50 : 72))
                            .minimumScaleFactor(0.01)
                            .multilineTextAlignment(.center)
                            .frame(height:70)
                            .frame(width:140)
                            .padding(.bottom, geometry.size.width == 320.0 ? 10 : 30)
                        
                        Text("""
                                Emoji
                                Category
                            """)
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                            .padding(.trailing, geometry.size.width == 320.0 ? 30 : 40 )

                            .padding(.bottom, 20)
                        
                        Spacer()

                            //.isHidden(geometry.size.width == 320.0 ? true : false, remove: geometry.size.width == 320.0 ? true : false)
                    }

            
                    VStack() {
                        HStack(spacing: 10) {
                            TextField("User", text: self.$user)
                                .font(.system(size: geometry.size.width == 320.0 ? 16 : 18))
                                .keyboardType(.asciiCapable)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                            
                            Button(action: copyUser) {
                                Text("Copy")
                            }.font(.system(size: geometry.size.width == 320.0 ? 16 : 18))
                            
                        }.padding(.horizontal, 40)
                        .padding(.bottom, 20)
                        HStack(spacing: 10) {
                            TextField("Pass", text: self.$pass)
                                .font(.system(size: geometry.size.width == 320.0 ? 16 : 18))
                                .keyboardType(.asciiCapable)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                            
                            Button(action: copyPass) {
                                Text("Copy")
                            }.font(.system(size: geometry.size.width == 320.0 ? 16 : 18))
                            
                        }.padding(.horizontal, 40)
                        .padding(.bottom, 20)
                        Spacer()
                    }
                }
            }
            
        }
        
        
        
        .onAppear() {
            if key == pencil {
                key = ""
            }
            emojiText = key
            print(emojiText,key)
            if !emojiText.isEmpty {
                loadData()
            }
        }
        
    }
    
    func fromScratch() {
        key = ""
        emojiText = ""
        user = ""
        pass = ""
    }
    
    func copyUser() {
        pasteboard.string = user
    }
    
    func copyPass() {
        pasteboard.string = pass
    }
    
    func savePass() {
        pasteboard.string = pass
    }
    
    func loadPass() {
        pasteboard.string = pass
    }
    
    func saveData() {
        let userData = encyptData(string: user)
        let passData = encyptData(string: pass)
        
        gSafe[emojiText] = [userData, passData]
        UserDefaults.standard.setValue(gSafe, forKey: "gSafe")
    }
    
    func loadData() {
        print(gSafe)
        
        if let data = gSafe[emojiText] as? [Data] {
            let userData = data[0] as Data
            let passData = data[1] as Data
            print(userData)
            print(passData)
            
            if userData.count > 0 {
                user = decrpytData(data: userData)
                print(user)
            }
            
            if passData.count > 0 {
                pass = decrpytData(data: passData)
                print(pass)
            }
        } else {
            emojiText = ""
            key = ""
        }
        
        
    }
}


/*struct EmojiTF_Previews: PreviewProvider {
 static var previews: some View {
 EmojiTF(key: "123")
 }
 }*/




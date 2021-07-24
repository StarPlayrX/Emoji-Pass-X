//
//  ListItem.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 2/27/21.
//

import CoreData

class ListItem: NSManagedObject {
    @NSManaged var order: Int
    //@NSManaged var dateString: String
    @NSManaged var emoji: String
    @NSManaged var name: String
    @NSManaged var templateId: Int
    @NSManaged var uuidString: String
    @NSManaged var isParent: Bool
    @NSManaged var star: Bool
    @NSManaged var lock: Bool
    @NSManaged var desc: String //Cat Desc, plain text, to be used for accessibility
    
    @NSManaged var id: Data //Random Encrypted Private Key
  
    //MARK: Replacement Password Encrpyted Items
    @NSManaged var pUsername: Data
    @NSManaged var pPassword: Data
    @NSManaged var pWebsite: Data
    @NSManaged var pPhone: Data
    @NSManaged var pPin: Data
    @NSManaged var pNotes: Data

    //MARK: Replacement Card Encrpyted Items
    @NSManaged var cBankname: Data
    @NSManaged var cCardnumber: Data
    @NSManaged var cCvc: Data
    @NSManaged var cExpdate: Data
    @NSManaged var cFullname: Data
    @NSManaged var cNotes: Data

    //MARK: Replacement Keys Encrpyted Items
    @NSManaged var kSoftwarepkg: Data
    @NSManaged var kLicensekey: Data
    @NSManaged var kEmailaddress: Data
    @NSManaged var kWebaddress: Data
    @NSManaged var kSeats: Data
    @NSManaged var kNotes: Data
}

extension ListItem {
    static func getFetchRequest() -> NSFetchRequest<ListItem> {
        if let request = ListItem.fetchRequest() as? NSFetchRequest<ListItem> {
            request.entity = ListItem.entity()
            request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
            return request
        }
    }
}

let template = ["💳 Cards", "🔒 Passwords", "🔑 Keys"]
let templateIds = [0, 1, 2]
var isGlobalDark = true

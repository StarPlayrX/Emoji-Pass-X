//
//  Enums.swift
//  Emoji Pass X
//
//  Created by Todd Bruss on 7/26/21.
//

import SwiftUI

enum CategoryType: String {
    case stars = "Stars"
    case everything = "Everything"
    case other = "Other"
}

enum AppStrings: String {
    case copyright = "© 2021 Todd Bruss"
    case star = "⭐️"
    case magnifier = "🔍"
}

enum CategoryStrings: String {
    case emoji = ":)"
    case caterpillar = "🐛"
    case name = "Category Name"
    case newCategory = "New Category"
    case enter = "Enter"
    case copy = "Copy"
    case desc = "Description"
}

enum ListStrings: String {
    case emoji = ":)"
    case pencil = "✏️"
    case name = "Name"
    case newRecord = "New Record"
}

enum ItemStrings: String {
    case emoji = ":)"
    case pencil = "✏️"
    case newRecord = "New Record"
}

enum NotesStrings: String {
    case Notes = "Notes"
    case cNotes = "cNotes"
    case pNotes = "pNotes"
    case kNotes = "kNotes"
}

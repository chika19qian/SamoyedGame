//
//  JournalEntry.swift
//  Samoedo
//
//  Created by chika on 2025/2/6.
//

import SwiftData
import Foundation

@Model
class JournalEntry {
    var date: Date
    var content: String
    var type: String  // "早安日记" or "晚安日记"

    init(date: Date, content: String, type: String) {
        self.date = date
        self.content = content
        self.type = type
    }
}


//
//  JournalEntry.swift
//  Samoedo
//
//  Created by chika on 2025/2/6.
//

import Foundation

import Foundation

struct JournalEntry: Codable, Identifiable {
    var id: UUID = UUID()
    var date: Date
    var content: String
    
    func isToday() -> Bool {
        return Calendar.current.isDateInToday(date)
    }
}


//
//  JournalEntry.swift
//  Samoedo
//
//  Created by chika on 2025/2/6.
//

import Foundation

struct JournalEntry: Codable, Identifiable {
    var id: UUID = UUID()
    var date: Date
    var step1Response: String
    var step2Response: [Event]
    var step3Response: String
    var step4Response: String
    var step5Response: String
    var journalContent: String
    
    
    var isMorning: Bool {
        let hour = Calendar.current.component(.hour, from: date)
        return hour < 14
    }
    func isToday() -> Bool {
        return Calendar.current.isDateInToday(date)
    }
}





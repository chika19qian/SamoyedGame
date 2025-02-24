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
    var previewText: String
    
    init(id: UUID = UUID(), date: Date, step1Response: String, step2Response: [Event], step3Response: String, step4Response: String, step5Response: String, journalContent: String) {
        self.id = id
        self.date = date
        self.step1Response = step1Response
        self.step2Response = step2Response
        self.step3Response = step3Response
        self.step4Response = step4Response
        self.step5Response = step5Response
        self.journalContent = journalContent
        self.previewText = JournalEntry.generatePreviewText(from: journalContent)
    }

    
    static func generatePreviewText(from content: String) -> String {
        let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

        if lines.count >= 2 {
            return lines.prefix(2).joined(separator: " ") // TODO 显示前两行
        } else {
            return lines.first ?? "📔"
        }
    }

    
    
    var isMorning: Bool {
        let hour = Calendar.current.component(.hour, from: date)
        return hour < 14
    }
    func isToday() -> Bool {
        return Calendar.current.isDateInToday(date)
    }
}





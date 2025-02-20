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
    let previewText: String
    
    init(id: UUID = UUID(), date: Date, step1Response: String, step2Response: [Event], step3Response: String, step4Response: String, step5Response: String, journalContent: String) {
        self.id = id
        self.date = date
        self.step1Response = step1Response
        self.step2Response = step2Response
        self.step3Response = step3Response
        self.step4Response = step4Response
        self.step5Response = step5Response
        self.journalContent = journalContent
        self.previewText = JournalEntry.generatePreviewText(from: step2Response)
    }


    static func generatePreviewText(from step2Response: [Event]) -> String {
        let step2Selection = step2Response.map { "\($0.icon) \($0.name)" }.joined(separator: ", ")
        return step2Selection.isEmpty ? "Journal" : step2Selection
    }

    
    
    var isMorning: Bool {
        let hour = Calendar.current.component(.hour, from: date)
        return hour < 14
    }
    func isToday() -> Bool {
        return Calendar.current.isDateInToday(date)
    }
}





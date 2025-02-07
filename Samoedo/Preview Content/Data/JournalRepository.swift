//
//  JournalRepository.swift
//  Samoedo
//
//  Created by chika on 2025/2/6.
//
import Foundation

class JournalRepository {
    private let morningKey = "morningJournalSaved"
    private let eveningKey = "eveningJournalSaved"

    
    func isMorningNow() -> Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour < 14
    }

    func hasJournalForToday(morning: Bool) -> Bool {
        let key = morning ? morningKey : eveningKey
        if let savedData = UserDefaults.standard.data(forKey: key),
           let entry = try? JSONDecoder().decode(JournalEntry.self, from: savedData) {
            return entry.isToday()
        }
        return false
    }

    func saveJournal(morning: Bool, content: String) {
        let key = morning ? morningKey : eveningKey
        let entry = JournalEntry(date: Date(), content: content)
        
        if let encoded = try? JSONEncoder().encode(entry) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    func loadJournal(morning: Bool) -> JournalEntry? {
        let key = morning ? morningKey : eveningKey
        if let savedData = UserDefaults.standard.data(forKey: key),
           let entry = try? JSONDecoder().decode(JournalEntry.self, from: savedData) {
            return entry
        }
        return nil
    }
}


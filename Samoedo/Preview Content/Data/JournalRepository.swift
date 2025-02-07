//
//  JournalRepository.swift
//  Samoedo
//
//  Created by chika on 2025/2/6.
//
import Foundation

class JournalRepository {
    private let allJournalsKey = "allJournals"
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

        var allJournals = loadAllJournals()
        allJournals.append(entry)  // ✅ 追加新日记，不覆盖旧日记
        if let encoded = try? JSONEncoder().encode(allJournals) {
            UserDefaults.standard.set(encoded, forKey: allJournalsKey)
        }

        print("Saved successfully!")
    }


    func loadJournal(morning: Bool) -> JournalEntry? {
        let key = morning ? morningKey : eveningKey
        if let savedData = UserDefaults.standard.data(forKey: key),
           let entry = try? JSONDecoder().decode(JournalEntry.self, from: savedData) {
            return entry
        }
        return nil
    }


    func loadAllJournals() -> [JournalEntry] {
        if let savedData = UserDefaults.standard.data(forKey: allJournalsKey),
           let journals = try? JSONDecoder().decode([JournalEntry].self, from: savedData) {
            return journals
        }
        return []
    }

    func deleteJournal(id: UUID) {
        var journals = loadAllJournals()
        journals.removeAll { $0.id == id }

        if let encoded = try? JSONEncoder().encode(journals) {
            UserDefaults.standard.set(encoded, forKey: allJournalsKey)
        }
        print("Deleted successfully!")
    }
}


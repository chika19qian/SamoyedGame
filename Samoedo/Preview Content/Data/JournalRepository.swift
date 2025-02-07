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
            return Calendar.current.isDateInToday(entry.date)
        }
        return false
    }



    func saveJournal(_ entry: JournalEntry) {
        let key = entry.isMorning ? morningKey : eveningKey
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let formattedDate = formatter.string(from: entry.date)

        if let encoded = try? JSONEncoder().encode(entry) {
            UserDefaults.standard.set(encoded, forKey: key)
            print("✅ 日记已保存: \(entry.step1Response) 到 key: \(key) - 存储时间: \(formattedDate)")

            // 🔍 Verify storage
            if let retrievedData = UserDefaults.standard.data(forKey: key),
               let retrievedEntry = try? JSONDecoder().decode(JournalEntry.self, from: retrievedData) {
                let retrievedDate = formatter.string(from: retrievedEntry.date)
                print("🔍 Confirmed stored: \(retrievedEntry.step1Response) - Retrieved at: \(retrievedDate)")
            } else {
                print("❌ Storage failed, unable to retrieve data")
            }
        } else {
            print("❌ JSON encoding failed!")
        }

        var allJournals = loadAllJournals()
        allJournals.append(entry)
        if let encoded = try? JSONEncoder().encode(allJournals) {
            UserDefaults.standard.set(encoded, forKey: allJournalsKey)
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
        print("🗑 Deleted journal with ID: \(id)")
    }
}


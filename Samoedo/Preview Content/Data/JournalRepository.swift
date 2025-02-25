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
    private let moodJournalKey = "moodJournalSaved"  // ✅ 新增 Mood Journal 独立 Key

    func isMorningNow() -> Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour > 5 && hour < 14
    }
    

    func hasJournalForToday(morning: Bool) -> Bool {
        let key = morning ? morningKey : eveningKey
        if let savedData = UserDefaults.standard.data(forKey: key),
           let entry = try? JSONDecoder().decode(JournalEntry.self, from: savedData) {
            return (entry.mode == .morning || entry.mode == .evening) && Calendar.current.isDateInToday(entry.date)
        }
        return false
    }


    func saveJournal(_ entry: JournalEntry) {
        let key: String
        if entry.mode == .mood {
            key = moodJournalKey
        } else {
            key = entry.isMorning ? morningKey : eveningKey
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let formattedDate = formatter.string(from: entry.date)

        if let encoded = try? JSONEncoder().encode(entry) {
            UserDefaults.standard.set(encoded, forKey: key)
            print("✅ 日记已保存: \(entry.step1Response) 到 key: \(key) - 存储时间: \(formattedDate)")

            // 🔍 确保存储成功
            if let retrievedData = UserDefaults.standard.data(forKey: key),
               let retrievedEntry = try? JSONDecoder().decode(JournalEntry.self, from: retrievedData) {
                let retrievedDate = formatter.string(from: retrievedEntry.date)
                print("🔍 确认存储: \(retrievedEntry.step1Response) - 读取时间: \(retrievedDate)")
            } else {
                print("❌ 存储失败，无法读取数据")
            }
        } else {
            print("❌ JSON 编码失败！")
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
    
    func loadJournalsByMode(_ mode: JournalMode) -> [JournalEntry] {
        return loadAllJournals().filter { $0.mode == mode }
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
    
    func updateJournal(entry: JournalEntry) {
        var journals = loadAllJournals()

        if let index = journals.firstIndex(where: { $0.id == entry.id }) {
            journals[index] = entry
        }

        if let encoded = try? JSONEncoder().encode(journals) {
            UserDefaults.standard.set(encoded, forKey: allJournalsKey)
            UserDefaults.standard.synchronize()
        }
        print("✏️ Updated journal with ID: \(entry.id)")
    }

    //For Dialogues
    func getLatestEmotionScore() -> Int {
        let allJournals = loadAllJournals().sorted(by: { $0.date > $1.date })
        guard let latestJournal = allJournals.first else {
            print("⚠️ No journal data found, returning default emotion score 3")
            return 3  // 默认值
        }

        if let emotionValue = Int(latestJournal.step1Response) {
            print("📝 Latest journal emotion score: \(emotionValue)")
            return emotionValue
        } else {
            print("❌ Invalid emotion score, returning default 3")
            return 3
        }
    }



}


//
//  JournalRepository.swift
//  Samoedo
//
//  Created by chika on 2025/2/6.
//
import SwiftUI
import Foundation

class JournalRepository {
    private let morningKey = "morningJournalSaved"
    private let eveningKey = "eveningJournalSaved"
    
    func hasJournalForToday(morning: Bool) -> Bool {
        let key = morning ? morningKey : eveningKey
        let lastSavedDate = UserDefaults.standard.object(forKey: key) as? Date ?? Date.distantPast
        return Calendar.current.isDateInToday(lastSavedDate)
    }
    
    func saveJournal(morning: Bool) {
        let key = morning ? morningKey : eveningKey
        UserDefaults.standard.set(Date(), forKey: key)
    }
}

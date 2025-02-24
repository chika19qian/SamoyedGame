//
//  JournalReviewViewModel.swift
//  Samoedo
//
//  Created by chika on 2025/2/7.
//

import Foundation

class JournalReviewViewModel: ObservableObject {
    private let journalRepository = JournalRepository()

    @Published var journalEntries: [JournalEntry] = []  

    init() {
        loadJournals()
    }

    func loadJournals() {
        journalEntries = journalRepository.loadAllJournals().sorted { $0.date > $1.date }
    }
    
    func deleteJournal(_ entry: JournalEntry) {
        journalRepository.deleteJournal(id: entry.id)
        journalEntries.removeAll { $0.id == entry.id }
        loadJournals()
    }
    
    
    func updateJournal(entry: JournalEntry, newContent: String) {
        if let index = journalEntries.firstIndex(where: { $0.id == entry.id }) {
            journalEntries[index].journalContent = newContent
            journalRepository.updateJournal(entry: journalEntries[index])
            objectWillChange.send()
        }
    }

    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: date)
    }

}

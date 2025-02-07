//
//  JournalReveiwViewModel.swift
//  Samoedo
//
//  Created by chika on 2025/2/7.
//

import Foundation

class JournalReviewViewModel: ObservableObject {
    private let journalRepository = JournalRepository()

    @Published var journalEntries: [JournalEntry] = []  // ✅ 存储所有日记

    init() {
        loadJournals()
    }

    func loadJournals() {
        journalEntries = journalRepository.loadAllJournals().sorted { $0.date > $1.date }
    }
    
    func deleteJournal(_ entry: JournalEntry) {
        journalRepository.deleteJournal(id: entry.id)
        journalEntries.removeAll { $0.id == entry.id }
        objectWillChange.send()
    }
    
    
    func updateJournal(entry: JournalEntry, newContent: String) {
        if let index = journalEntries.firstIndex(where: { $0.id == entry.id }) {
            journalEntries[index].journalContent = newContent
            journalRepository.updateJournal(entry: journalEntries[index])
            objectWillChange.send()
        }
    }

    func randomizedPreviewText(_ content: String) -> String {
        let responses = content.split(separator: "\n\n")
            .map { String($0) }
            .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        
        return responses.randomElement() ?? "No content available"
    }


}

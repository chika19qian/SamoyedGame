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
}

//
//  JournalViewModel.swift
//  Samoedo
//
//  Created by chika on 2025/2/7.
//

import Foundation
import Combine

class JournalViewModel: ObservableObject {
    private let journalRepository = JournalRepository()
    @Published var content: String = ""
    @Published var didSaveJournal = false
    var morning: Bool

    init(morning: Bool) {
        self.morning = morning
        loadJournal()
    }

    func loadJournal() {
        if let entry = journalRepository.loadJournal(morning: morning) {
            content = entry.content
        }
    }

    func saveJournal() {
        journalRepository.saveJournal(morning: morning, content: content)
        didSaveJournal = true
    }
}



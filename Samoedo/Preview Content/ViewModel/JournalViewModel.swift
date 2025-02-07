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
    var onSave: (() -> Void)?

    init() {
        let hour = Calendar.current.component(.hour, from: Date())
        self.morning = hour < 14  
        loadJournal()
    }


    func loadJournal() {
        if let entry = journalRepository.loadJournal(morning: morning) {
            content = entry.content
        }
    }

    func saveJournal() {
        print("jvm的savejournal被调用，morning:\(morning),content:\(content)")
        journalRepository.saveJournal(morning: morning, content: content)
        didSaveJournal = true
        onSave?()
    }
}



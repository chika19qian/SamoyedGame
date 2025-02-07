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
    @Published var entries: [JournalEntry] = []
    @Published var step: Int = 1
    @Published var stepPath: [Int] = [1]
    @Published var currentEntry: JournalEntry = JournalEntry(
        id: UUID(),
        date: Date(),
        step1Response: "",
        step2Response: [],
        step3Response: "",
        step4Response: "",
        step5Response: ""
    )
    
    var content: String {
        get {
            """
            \(currentEntry.step1Response)
            \(currentEntry.step2Response.map { $0.name }.joined(separator: ", "))
            \(currentEntry.step3Response)
            \(currentEntry.step4Response)
            \(currentEntry.step5Response)
            """
        }
        set {
            currentEntry.step1Response = newValue 
        }
    }
    
    var morning: Bool
    var onSave: (() -> Void)?

    init() {
        let hour = Calendar.current.component(.hour, from: Date())
        self.morning = hour < 14  
    }


    func saveJournal() {
        print("保存日记")
        journalRepository.saveJournal(currentEntry)
        onSave?()
    }
    
    func nextStep() {
        if step < 5 {
            step += 1
            if !stepPath.contains(step) { 
                stepPath.append(step)
            }
            print("Next step: \(step)")
        }
    }
    
    func previousStep() {
        if step > 1 {
            step -= 1
            stepPath.removeLast()
        }
    }
    
}



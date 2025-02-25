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
        mode: .morning,
        step1Response: "",
        step2Response: [],
        step3Response: "",
        step4Response: "",
        step5Response: "",
        journalContent: ""
    )
    
    var content: String {
        get {
            let step2Selection = currentEntry.step2Response.map { "\($0.icon) \($0.localizedName)" }.joined(separator: ", ")

            let step3Question = step2Selection.isEmpty
                ? (morning ? String(localized: "What beautiful memories do you have about your focus areas?")
                           : String(localized: "Why did the chosen event make you feel good?"))
                : (morning ? String(format: String(localized: "What beautiful memories do you have about %@?"), step2Selection)
                           : String(format: String(localized: "Why did %@ make you feel good?"), step2Selection))

            let step4Question = step2Selection.isEmpty
                ? (morning ? String(localized: "What is your plan for today?")
                           : String(localized: "How would you praise yourself?"))
                : (morning ? String(format: String(localized: "What is your plan for %@ today?"), step2Selection)
                           : String(localized: "How would you praise yourself?"))

            var contentArray: [String] = []

            contentArray.append(
                String(format: String(localized: morning
                    ? "How was your sleep last night?\n%@/5"
                    : "How do you feel today?\n%@/5"), currentEntry.step1Response)
            )

            contentArray.append(
                String(format: String(localized: morning
                    ? "What did you focus on today?\n%@"
                    : "What made you feel good today?\n%@"), step2Selection)
            )

            if !currentEntry.step3Response.isEmpty {
                contentArray.append(
                    String(format: "%@\n%@", step3Question, currentEntry.step3Response)
                )
            }

            if !currentEntry.step4Response.isEmpty {
                contentArray.append(
                    String(format: "%@\n%@", step4Question, currentEntry.step4Response)
                )
            }

            if !currentEntry.step5Response.isEmpty {
                contentArray.append(
                    String(format: String(localized: morning
                        ? "If today is fulfilling and brings unexpected joy, how would you feel?\n%@"
                        : "What beautiful things are you looking forward to tomorrow?\n%@"),
                        currentEntry.step5Response)
                )
            }

            return contentArray.joined(separator: "\n\n")
        }
    }


    
    var morning: Bool
    var onSave: (() -> Void)?

    init() {
        let hour = Calendar.current.component(.hour, from: Date())
        self.morning = hour < 14 && hour > 5
    }


    func saveJournal(vm: MainViewModel) {
        print("保存日记")
        currentEntry.journalContent = content
        currentEntry.date = Date()
        journalRepository.saveJournal(currentEntry)
        vm.gainFoodJournal()
        vm.journalChoicePhase = false
        
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
    
    func generateStep3Question() -> String {
        let selectedEvents = currentEntry.step2Response
        let eventNames = selectedEvents.map { "\($0.icon) \($0.localizedName)" }.joined(separator: ", ")

        if eventNames.isEmpty {
            return String(localized: morning ? "morning.step3.default" : "evening.step3.default")
        } else {
            return String(
                localized: morning ? "morning.step3.dynamic" : "evening.step3.dynamic",
                defaultValue: "What beautiful memories do you have about \(eventNames)?"
            )
        }
    }

    func generateStep4Question() -> String {
        let selectedEvents = currentEntry.step2Response
        let eventNames = selectedEvents.map { "\($0.icon) \($0.name)" }.joined(separator: ", ")

        return String(
            localized: morning ? "morning.step4" : "evening.step4",
            defaultValue: "What is your plan for \(eventNames) today?"
        )
    }

    
}




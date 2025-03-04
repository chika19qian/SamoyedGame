//
//  MoodJournalViewModel.swift
//  SamoDiary
//
//  Created by chika on 2025/2/24.
//

import Foundation
import Combine

class MoodJournalViewModel: ObservableObject {
    @Published var step: Int = 1
    @Published var selectedMood: MoodCategory? = nil
    @Published var selectedEvents: [Event] = []
    @Published var selectedMoodDetails: [String] = []
    @Published var userInputReason: String = ""
    
    @Published var currentEntry: JournalEntry  // 确保 `currentEntry` 存在

    private let journalRepository = JournalRepository()
    var onSave: (() -> Void)?  // 触发保存后的回调

    init() {
        // 初始化 `currentEntry`
        self.currentEntry = JournalEntry(
            id: UUID(),
            date: Date(),
            mode: .mood,
            step1Response: "",
            step2Response: [],
            step3Response: "",
            step4Response: "",
            step5Response: "",
            journalContent: ""
        )
    }
    
    var content: String {
        get {
            // Step 1: 用户选择的心情
            let step1Question = String(localized: "Today's Mood")
            let step1Answer = currentEntry.step1Response.isEmpty ? String(localized: "Not selected") : NSLocalizedString(currentEntry.step1Response, comment: "")

            // Step 2: 影响心情的事件
            let step2Question = String(localized: "Events that influenced your mood")
            let step2Answer = currentEntry.step2Response.isEmpty
                ? String(localized: "No events selected")
            : currentEntry.step2Response.map { "\($0.icon) \($0.localizedName)" }.joined(separator: ", ")


            let step3Question = String(localized: "Specific Feelings")
            let step3Answer = currentEntry.step3Response.isEmpty
                ? String(localized: "No specific feelings recorded")
                : currentEntry.step3Response


            let step4Question = String(localized: "Reason")
            let step4Answer = currentEntry.step4Response.isEmpty ? String(localized: "No reason provided") : currentEntry.step4Response


            let step5Question = String(localized: "Any additional reflections?")
            let step5Answer = currentEntry.step5Response.isEmpty ? "" : currentEntry.step5Response


            var contentArray: [String] = []
            contentArray.append("\(step1Question)\n\(step1Answer)")
            contentArray.append("\(step2Question)\n\(step2Answer)")
            contentArray.append("\(step3Question)\n\(step3Answer)")
            contentArray.append("\(step4Question)\n\(step4Answer)")

            if !step5Answer.isEmpty {
                contentArray.append("\(step5Question)\n\(step5Answer)")
            }

            return contentArray.joined(separator: "\n\n")
        }
    }


    func nextStep() {
        if step < 4 { step += 1 }
    }

    func previousStep() {
        if step > 1 { step -= 1 }
    }

    func selectMood(_ mood: MoodCategory) {
        selectedMood = mood
        nextStep()
    }

    func saveJournal(vm: MainViewModel) {
        print("Saving Mood Journal")

        // 更新 `currentEntry`
        currentEntry.date = Date()
        currentEntry.mode = .mood
        currentEntry.step1Response = selectedMood?.rawValue ?? ""
        currentEntry.step2Response = selectedEvents
        currentEntry.step3Response = selectedMoodDetails.joined(separator: ", ")
        currentEntry.step4Response = userInputReason
        currentEntry.step5Response = ""

        currentEntry.journalContent = content

        journalRepository.saveJournal(currentEntry)

        vm.gainFoodMoodJournal()

        onSave?()

    }


}

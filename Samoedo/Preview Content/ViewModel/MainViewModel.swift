//
//  MainViewModel.swift
//  Samoedo
//
//  Created by chika on 2025/2/6.
//

import Foundation
import SwiftUI
import Combine


class MainViewModel: ObservableObject {
    @Published var pet: Pet
    private var repository = PetRepository()
    private var journalRepository = JournalRepository()
    private var storyRepository = StoryRepository()
    
    // First Scenes Check
    @Published var showOpeningScene = false
    @Published var openingDialogueIndex = 0
    @Published var dogName: String = "Samoyed"
    @Published var isNamingDog = false
    @Published var openJournal = false
    @Published var navigateToMain = false
    @Published var isOpeningSceneFinished = false


    // initial prompt
    @Published var hasMorningJournal = false
    @Published var hasEveningJournal = false
    @Published var showJournalPrompt = false
    @Published var journalChoicePhase = false
    private var lastSkippedTime: Date? 
    
    // dialog with dog
    @Published var showingDialog = false
    @Published var dialogMessage = ""
    private var dialogDismissTimer: Timer?

    
    @Published var showAgeInfo = false

    
    init() {
        pet = repository.loadData()
        checkJournalStatus()
        
        //check first story
        if !storyRepository.hasSeenOpening() {
            showOpeningScene = true
            print("✅ First launch: Showing opening scene")
        } else {
            showOpeningScene = false
            print("✅ Opening scene already seen: Skipping to main")
        }
    }
    
// Story First !

    func nextOpeningDialogue() {
        print("🔍 Check: openingDialogueIndex = \(openingDialogueIndex), story count = \(Dialogues.story.count), isOpeningSceneFinished = \(isOpeningSceneFinished)")

        if openingDialogueIndex == 7 {
            isNamingDog = true
            return
        }
        if openingDialogueIndex < Dialogues.story.count - 1  {
            openingDialogueIndex += 1
            print("➡️ Moving to next dialogue: \(openingDialogueIndex)")
        } else {
            print("✅ nextOpeningDialogue: Marking opening scene as seen")
            storyRepository.setSeenOpening()
            DispatchQueue.main.async {
                withAnimation {
                    self.showOpeningScene = false
                    self.showJournalPrompt = true
                    self.isOpeningSceneFinished = true
                    print("🏠 Transitioning to MainView")
                }
            }
        }
    }
    
    
    func confirmDogName(newName: String) {
        if newName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            dogName = "Samoyed"
        } else {
            pet.name = newName
            repository.saveData(pet: pet)
            isNamingDog = false
            openingDialogueIndex += 1
        }
        
    }
    
// Daily
    
    func checkJournalStatus() {
        if showOpeningScene {
            showJournalPrompt = false
            return }
        
        let isMorning = journalRepository.isMorningNow()
        hasMorningJournal = journalRepository.hasJournalForToday(morning: true)
        hasEveningJournal = journalRepository.hasJournalForToday(morning: false)

        if let lastSkipped = lastSkippedTime, Date().timeIntervalSince(lastSkipped) < 3600 {
            showJournalPrompt = false
        } else {
            showJournalPrompt = isMorning ? !hasMorningJournal : !hasEveningJournal
        }
        
        print("⏳ 早晨日记: \(hasMorningJournal), 晚上日记: \(hasEveningJournal), 当前时间早晨? \(isMorning)")
        objectWillChange.send()
    }
    
    func showJournalButtons() {
        withAnimation {
            showJournalPrompt = false
            journalChoicePhase = true
        }
    }
    
    func skipJournal() {
        showJournalPrompt = false
        journalChoicePhase = false
        lastSkippedTime = Date()
        objectWillChange.send()
    }
    
    func didTapSamoyed() {
        if showJournalPrompt {return}
        
        dialogMessage = Dialogues.messages.randomElement() ?? "Woof!"
        showingDialog = true
        
        startDialogDismissTimer()
        print("萨摩耶被点击了！")
    }
    
    func didTapChatbot() {
        if !showingDialog { return }
        dialogMessage = Dialogues.messages.randomElement() ?? "Woof!"
        startDialogDismissTimer()
    }
    
    private func startDialogDismissTimer() {
        dialogDismissTimer?.invalidate()
        dialogDismissTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.showingDialog = false
        }
    }
    
    func saveData() {
        objectWillChange.send()
        repository.saveData(pet: pet)
    }
    
    func feed() {
        pet.feed()
        saveData()
    }
    
    func gainFoodJournal() {
        print("📖 写日记获得 3 份狗粮")
        pet.gainFood(amount: 3)
        objectWillChange.send()
        saveData()
        print("🍖 当前狗粮数量: \(pet.foodCount)")
    }

}




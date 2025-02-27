//
//  MainViewModel.swift
//  SamoDiary
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
    var emotionScore: Int {
        return journalRepository.getLatestEmotionScore()
    }

    @Published var showAgeInfo = false

    // change views
    @Published var navigateToSettings = false
    @Published var isMeditationActive = false
    @Published var fromMeditation = false
    
    //Tutorial
    @Published var tutorialStep: Int = 0
    @Published var isTutorialActive: Bool = true
    @Published var highlightFeedButton: Bool = false
    @Published var highlightMoodJournal: Bool = false

    
    init() {
        // bgm
        let selectedBGM = AudioRepository.shared.getSelectedBGM()
        let shouldPlayBGM = AudioRepository.shared.isBGMPlaying()

        if shouldPlayBGM {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                AudioManager.shared.playBGM(filename: selectedBGM)
            }
        } else {
            print("🔇 BGM 被用户关闭，启动时不播放")
        }
        pet = repository.loadData()
        checkJournalStatus()
        
        //check first story
        if !storyRepository.hasSeenOpening() {
            showOpeningScene = true
            print("✅ First launch: Showing opening scene")
        } else if !storyRepository.hasSeenTutorial() {
            isTutorialActive = true
        }
        else {
            showOpeningScene = false
            isTutorialActive = false
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
            
            pet.birthday = Date()
            repository.saveData(pet: pet)
            
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
    
    func nextTutorialStep() {
        tutorialStep += 1
        if tutorialStep == 4 {
            highlightFeedButton = true
            highlightMoodJournal = false
        } else if tutorialStep == 3 {
            highlightFeedButton = false
            highlightMoodJournal = true
        } else {
            highlightFeedButton = false
            highlightMoodJournal = false
        }

        if tutorialStep >= Dialogues.tutorial.count {
            isTutorialActive = false
            storyRepository.setSeenTutorial()
            checkJournalStatus()
        }
    }


    
// Daily
    
    func checkJournalStatus() {
        if showOpeningScene || isTutorialActive {
            showJournalPrompt = false
            return }
        
        let isMorning = journalRepository.isMorningNow()
        hasMorningJournal = journalRepository.hasJournalForToday(morning: true)
        hasEveningJournal = journalRepository.hasJournalForToday(morning: false)

        if let lastSkipped = lastSkippedTime, Date().timeIntervalSince(lastSkipped) < 30 {
            showJournalPrompt = false
        } else {
            showJournalPrompt = isMorning ? !hasMorningJournal : !hasEveningJournal
        }
        
        print("⏳ 早晨日记: \(hasMorningJournal), 晚上日记: \(hasEveningJournal), 当前时间早晨? \(isMorning),日记提示\(showJournalPrompt)")
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
        if showingDialog { return }
        if showJournalPrompt {return}
        updateEmotionScore()
        dialogMessage = pet.getPetDialogue(emotionScore: emotionScore)
        showingDialog = true
        
        startDialogDismissTimer()
        print("萨摩耶被点击了！")
    }
    
    func didTapChatbot() {
        if !showingDialog { return }
        dialogMessage = pet.getPetDialogue(emotionScore: emotionScore)
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
        if highlightFeedButton {
            nextTutorialStep()
        }
    }
    
    func gainFoodJournal() {
        print("📖 写日记获得 3 份狗粮")
        pet.gainFood(amount: 3)
        objectWillChange.send()
        saveData()
        print("🍖 当前狗粮数量: \(pet.foodCount)")
    }
    
    func gainFoodMoodJournal() {
        print("获得 1份狗粮")
        pet.gainFood(amount: 1)
        objectWillChange.send()
        saveData()
        print("🍖 当前狗粮数量: \(pet.foodCount)")
    }
    
    func updateEmotionScore() {
        let latestJournalScore = journalRepository.getLatestEmotionScore()
        print("📝 Updated emotionScore to \(latestJournalScore)")
    }
    
// meditation
    func startMeditation() {
        isMeditationActive = true
        print("LongPressed")
    }

    func endMeditation() {
        isMeditationActive = false
    }
    
// change to settingsView
    func openSettings() {
        if !navigateToSettings {
            print("🟢 打开 SettingsView (fromMeditation: \(fromMeditation))")
            navigateToSettings = true
        } else {
            print("⚠️ 已经打开 SettingsView，阻止重复跳转")
        }
    }

    func endSettings() {
        if fromMeditation {
            isMeditationActive = true
        }
        navigateToSettings = false
        fromMeditation = false
    }


}




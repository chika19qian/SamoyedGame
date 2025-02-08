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
        
        private static let greetings = [
                    "Good morning! How do you feel today?",
                    "Hello! Hope you're having a great day!",
                    "Good evening! Did you have a nice day?"
                ]
        
        private static let messages = [
            "Hi","I'm your dog ","Hello! How are you?",
            "I love you!","How was your day?",
            "Did you have fun today?",
            "Tell me something interesting!"
        ]
        
        
        
        @Published var showJournalPrompt = false
        @Published var hasMorningJournal = false
        @Published var hasEveningJournal = false
        
        @Published private var currentMessageIndex = 0
        @Published private var greetingPhase = true
        @Published var journalChoicePhase = false
        @Published private var useGreeting = true
        @Published var showAgeInfo = false

        
        init() {
            pet = repository.loadData()
            checkJournalStatus()
        }
        
        var currentMessage: String {
            if showJournalPrompt {
                return "Would you like to record today’s journal?"
            } else {
                return getGreetingOrMessage()
            }
        }

        func getGreetingOrMessage() -> String {
            let hour = Calendar.current.component(.hour, from: Date())
            let greeting = Self.greetings[hour < 12 ? 0 : (hour < 18 ? 1 : 2)]
            let randomMessage = Self.messages.randomElement() ?? "Tell me something interesting!"
            return useGreeting ? greeting : randomMessage
        }
        
        func didTapChatbot() {
            if greetingPhase {
                greetingPhase = false
                useGreeting = false
                if showJournalPrompt {
                    journalChoicePhase = true
                }
                objectWillChange.send()
                return
            }
            
            if journalChoicePhase {
                return
            }
            
            useGreeting.toggle()
            currentMessageIndex = (currentMessageIndex + 1) % Self.messages.count
            objectWillChange.send()
        }

        

        func checkJournalStatus() {
            let isMorning = journalRepository.isMorningNow()
            hasMorningJournal = journalRepository.hasJournalForToday(morning: true)
            hasEveningJournal = journalRepository.hasJournalForToday(morning: false)
            showJournalPrompt = isMorning ? !hasMorningJournal : !hasEveningJournal
            if !showJournalPrompt {
                journalChoicePhase = false
            }
            let previousPrompt = showJournalPrompt
                showJournalPrompt = isMorning ? !hasMorningJournal : !hasEveningJournal
            print("🛠 `checkJournalStatus()` 运行中...")
            print("⏳ 早晨日记: \(hasMorningJournal), 晚上日记: \(hasEveningJournal), 当前时间早晨? \(isMorning)")
            print("🔄 `showJournalPrompt` 之前: \(previousPrompt) -> 现在: \(showJournalPrompt)")

            objectWillChange.send()
        }


        func skipJournal() {
            showJournalPrompt = false
            journalChoicePhase = false
            objectWillChange.send()
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
        
        func didTapSamoyed() {
            // 这里填写点击萨摩耶后的逻辑
            print("萨摩耶被点击了！")
        }
          
        

    }




//
//  PetModel.swift
//  Samoedo
//
//  Created by chika on 2025/2/6.
//

import Foundation

struct Pet: Codable {
    var name: String
    var birthday = Date()
    var lastMeal: Date
    var foodCount: Int = 5
    var ageOffset: Int = 0
    
    var happinessLevel: String {
        switch hunger {
        case "Hungry":
            return String(localized: "Unhappy")
        case "Getting hungry":
            return String(localized: "Normal")
        default:
            return String(localized: "Happy")
        }
    }

    
    var age: Int {
        let timeSince = calcTimeSince(data: birthday)
        let ageTime = timeSince + ageOffset
        return ageTime
    }
    
    var hunger: String {
        let timeSince = calcTimeSince(data: lastMeal)
        
        switch timeSince {
        case 0..<30: return String(localized: "Satiated")
        case 30..<60: return String(localized: "Getting hungry")
        case 60...: return String(localized: "Hungry")
        default: return String(localized: "Idk")
        }
    }

    
    var stage: String {
        switch age {
        case 0..<1000: return "Puppy"
        case 1000..<5000: return "Young"
        case 5000...: return "Adult"
        default: return "Idk"
        }
    }
    
    var currentStageEnd: Int {
        switch stage {
        case "Puppy": return 1000
        case "Young": return 5000
        case "Adult": return 120000
        default: return 1000000
        }
    }

    
    var stageProgress: Double {
            let stageStart: Int
            let stageEnd: Int

            switch stage {
            case "Puppy":
                stageStart = 0
                stageEnd = 1000
            case "Young":
                stageStart = 1000
                stageEnd = 5000
            case "Adult":
                stageStart = 5000
                stageEnd = 120000
            default:
                stageStart = 120000
                stageEnd = 1000000
            }

            let progress = Double(age - stageStart) / Double(stageEnd - stageStart)
            return min(max(progress, 0), 1)
        }
    
    var stageImage: String {
        if happinessLevel == "Normal" {
            switch stage {
            case "Puppy": return "puppy_normal"
            case "Young": return "young_normal"
            case "Adult": return "adult_normal"
            default: return "old_normal"
            }
        }

        
        switch stage {
        case "Puppy": return happinessLevel == "Happy" ? "puppy_happy_samoyed" : "puppy_sad_samoyed"
        case "Young": return happinessLevel == "Happy" ? "young_happy_samoyed" : "young_sad_samoyed"
        case "Adult": return happinessLevel == "Happy" ? "adult_happy_samoyed" : "adult_sad_samoyed"
        default: return happinessLevel == "Happy" ? "old_happy_samoyed" : "old_sad_samoyed"
        }
    }

    mutating func feed() {
        if foodCount > 0 {
            lastMeal = Date()
            ageOffset += 100
            foodCount -= 1
        }
    }
    
    mutating func gainFood(amount: Int) {
        foodCount += amount
    }
    
    func getPetDialogue(emotionScore: Int) -> String {
        return Dialogues.getDialogue(for: stage, hunger: hunger, emotionScore: emotionScore)
    }


}

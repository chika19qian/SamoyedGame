//
//  PetModel.swift
//  SamoDiary
//
//  Created by chika on 2025/2/6.
//

import Foundation

struct Pet: Codable {
    var name: String
    var birthday: Date?
    var lastMeal: Date
    var foodCount: Int = 5
    var ageOffset: Int = 0
    
    var happinessLevel: String {
        switch hunger {
        case String(localized: "Hungry"):
            return String(localized: "Unhappy")
        case String(localized: "Getting hungry"):
            return String(localized: "Normal")
        case String(localized: "Satiated"):
            return String(localized: "Happy")
        default:
            return String(localized: "Idk")
        }
    }

    
    var age: Int {
        guard let birthday = birthday else { return 0 }
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
        case 0..<1000: return  String(localized: "Puppy")
        case 1000..<5000: return String(localized: "Young")
        case 5000...: return String(localized: "Adult")
        default: return "Idk"
        }
    }
    
    var currentStageEnd: Int {
        switch stage {
        case String(localized: "Puppy"): return 1000
        case String(localized: "Young"): return 5000
        case String(localized: "Adult"): return 120000
        default: return 1000000
        }
    }

    
    var stageProgress: Double {
            let stageStart: Int
            let stageEnd: Int

            switch stage {
            case String(localized: "Puppy"):
                stageStart = 0
                stageEnd = 1000
            case String(localized: "Young"):
                stageStart = 1000
                stageEnd = 5000
            case String(localized: "Adult"):
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
        if happinessLevel == String(localized: "Normal") {
            switch stage {
            case String(localized: "Puppy"): return "puppy_normal"
            case String(localized: "Young"): return "young_normal"
            case String(localized: "Adult"): return "adult_normal"
            default: return "old_normal"
            }
        }
        
        else if happinessLevel == String(localized: "Happy") {
            switch stage {
            case String(localized: "Puppy"): return "puppy_happy"
            case String(localized: "Young"): return "young_happy"
            case String(localized: "Adult"): return "adult_happy"
            default: return "old_normal"
            }
        }

        else if happinessLevel == String(localized: "Unhappy") {
            switch stage {
            case String(localized: "Puppy"): return "puppy_sad_samoyed"
            case String(localized: "Young"): return "young_sad_samoyed"
            case String(localized: "Adult"): return "adult_sad_samoyed"
            default: return "old_sad_samoyed"
            }
        }
        
        else {
            return "old_normal"
        }
        
    }

    mutating func feed() {
        if foodCount > 0 {
            lastMeal = Date()
            ageOffset += 50
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

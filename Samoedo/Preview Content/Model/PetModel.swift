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
    
    var happinessLevel: String {
        hunger == "Hungry" ? "Unhappy" : "Happy"
    }
    
    var age: Int {
        let timeSince = calcTimeSince(data: birthday)
        return timeSince
    }
    
    var hunger: String {
        let timeSince = calcTimeSince(data: lastMeal)
        var string = ""
        
        switch timeSince {
        case 0..<30: string = "Satiated"
        case 30..<60: string = "Getting hungry"
        case 60...: string = "Hungry"
        default: string = "Idk"
        }
        
        return string
    }
    
    var stage: String {
        switch age {
        case 0..<600: return "Puppy"
        case 600..<1000: return "Young"
        case 1000...: return "Adult"
        default: return "Idk"
        }
    }
    
    var currentStageEnd: Int {
        switch stage {
        case "Puppy": return 600
        case "Young": return 1000
        case "Adult": return 50000
        default: return 120000
        }
    }

    
    var stageProgress: Double {
            let stageStart: Int
            let stageEnd: Int

            switch stage {
            case "Puppy":
                stageStart = 0
                stageEnd = 600
            case "Young":
                stageStart = 600
                stageEnd = 1000
            case "Adult":
                stageStart = 1000
                stageEnd = 50000
            default:
                stageStart = 50000
                stageEnd = 120000
            }

            let progress = Double(age - stageStart) / Double(stageEnd - stageStart)
            return min(max(progress, 0), 1)
        }
    
    var stageImage: String {
        switch stage {
        case "Puppy": return happinessLevel == "Happy" ? "puppy_happy_samoyed" : "puppy_sad_samoyed"
        case "Young": return happinessLevel == "Happy" ? "young_happy_samoyed" : "young_sad_samoyed"
        case "Adult": return happinessLevel == "Happy" ? "adult_happy_samoyed" : "adult_sad_samoyed"
        default: return happinessLevel == "Happy" ? "elder_happy_samoyed" : "elder_sad_samoyed"
        }
    }

    mutating func feed() {
        if foodCount > 0 {
            lastMeal = Date()
            foodCount -= 1
        }
    }
    
    mutating func gainFood(amount: Int) {
        foodCount += amount
    }
}

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
}

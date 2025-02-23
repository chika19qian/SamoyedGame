//
//  Event.swift
//  Samoedo
//
//  Created by chika on 2025/2/7.
//

import Foundation

struct Event: Identifiable, Codable {
    let id: UUID
    let name: String
    let icon: String
    
    var localizedName: String {
        NSLocalizedString(name, comment: "")
    }
}

let eventCategories: [Event] = [
    Event(id: UUID(), name: "Study", icon: "📖"),
    Event(id: UUID(), name: "Work", icon: "💼"),
    Event(id: UUID(), name: "Relationship", icon: "❤️"),
    Event(id: UUID(), name: "Food", icon: "🍲"),
    Event(id: UUID(), name: "Exercise", icon: "🏃‍♂️"),
    Event(id: UUID(), name: "Music", icon: "🎵"),
    Event(id: UUID(), name: "Art", icon: "🎨"),
    Event(id: UUID(), name: "Social", icon: "👫"),
    Event(id: UUID(), name: "Nature", icon: "🌳"),
    Event(id: UUID(), name: "Technology", icon: "📱"),
    Event(id: UUID(), name: "Sleep", icon: "💤"),
    Event(id: UUID(), name: "Meditation", icon: "🧘‍♀️")
]

//
//  MoodCategory.swift
//  Samoedo
//
//  Created by chika on 2025/2/24.
//

import Foundation

enum MoodCategory: String, Codable, CaseIterable {
    case veryBad = "Very Bad"
    case bad = "Bad"
    case neutral = "Neutral"
    case good = "Good"
    case veryGood = "Very Good"
    
    var localizedName: String {
        return String(localized: String.LocalizationValue(self.rawValue))
    }
}

let moodDetailsMap: [MoodCategory: [String]] = [
    .veryBad: [
        String(localized: "Sad"), String(localized: "Disappointed"), String(localized: "Anxious"),
        String(localized: "Angry"), String(localized: "Afraid"), String(localized: "Devastated"),
        String(localized: "Hopeless"), String(localized: "Depressed"), String(localized: "Heartbroken"),
        String(localized: "Miserable"), String(localized: "Overwhelmed"), String(localized: "Humiliated"),
        String(localized: "Ashamed"), String(localized: "Lonely"), String(localized: "Rejected")
    ],
    .bad: [
        String(localized: "Tired"), String(localized: "Bored"), String(localized: "Frustrated"),
        String(localized: "Jealous"), String(localized: "Annoyed"), String(localized: "Insecure"),
        String(localized: "Uncomfortable"), String(localized: "Confused"), String(localized: "Distracted"),
        String(localized: "Restless"), String(localized: "Worried"), String(localized: "Impatient"),
        String(localized: "Stressed"), String(localized: "Irritated"), String(localized: "Uneasy")
    ],
    .neutral: [
        String(localized: "Calm"), String(localized: "Relaxed"), String(localized: "Composed"),
        String(localized: "Content"), String(localized: "Relieved"), String(localized: "Balanced"),
        String(localized: "Neutral"), String(localized: "Stable"), String(localized: "Adequate"),
        String(localized: "Meditative"), String(localized: "Mindful"), String(localized: "Steady"),
        String(localized: "Tranquil"), String(localized: "Peaceful"), String(localized: "Patient")
    ],
    .good: [
        String(localized: "Happy"), String(localized: "Confident"), String(localized: "Grateful"),
        String(localized: "Lighthearted"), String(localized: "Optimistic"), String(localized: "Satisfied"),
        String(localized: "Comfortable"), String(localized: "Motivated"), String(localized: "Cheerful"),
        String(localized: "Enthusiastic"), String(localized: "Energetic"), String(localized: "Productive"),
        String(localized: "Inspired"), String(localized: "Focused"), String(localized: "Friendly")
    ],
    .veryGood: [
        String(localized: "Excited"), String(localized: "Fulfilled"), String(localized: "Appreciative"),
        String(localized: "Proud"), String(localized: "Hopeful"), String(localized: "Elated"),
        String(localized: "Blissful"), String(localized: "Thrilled"), String(localized: "Jubilant"),
        String(localized: "Passionate"), String(localized: "Triumphant"), String(localized: "Overjoyed"),
        String(localized: "Empowered"), String(localized: "Loved"), String(localized: "Accomplished")
    ]
]

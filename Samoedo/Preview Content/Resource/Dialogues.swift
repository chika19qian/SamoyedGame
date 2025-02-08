//
//  Dialogues.swift
//  Samoedo
//
//  Created by chika on 2025/2/8.
//

import Foundation

struct Dialogues {
    static let greetings = [
        "Good morning! How do you feel today?",
        "Hello! Hope you're having a great day!",
        "Good evening! Did you have a nice day?"
    ]

    static let messages = [
        "Hi", "I'm your dog 🐶", "Hello! How are you?",
        "I love you! ❤️", "How was your day?",
        "Did you have fun today?", "Tell me something interesting!"
    ]

    static let journalPrompt = "Would you like to record today’s journal?"
    
    static func getGreeting(for hour: Int) -> String {
        return greetings[hour < 12 ? 0 : (hour < 18 ? 1 : 2)]
    }
}

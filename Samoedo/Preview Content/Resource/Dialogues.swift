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
    
    static let fullStory = [
            // First Encounter 剧情
            "…Oh! Um… hi? Are you the one who found me? 🐾",
            "You’re looking at me… are you my new human? I think I was waiting for someone… but I don’t remember who. Or why.",
            "I don’t really know where I came from… but I woke up in this box. And now you’re here. So… I guess this is home now?",
            "You’re not going to leave me here, right? I mean… I don’t take up much space. I promise!",
            "Um… what’s that? There’s something in the box next to me. Looks like a book?",
            "It smells like… paper? ",
            "Oh, you’re opening it? What does it say? …Oh, wait. You have to write in it? Does that mean it’s yours?",
            "I don’t understand… but if it’s important to you, then I’ll make sure you remember to use it!",
            "Um… if you write in it, will you write about me too? I wanna know what you think of me.",

            // Notebook Introduction 剧情
            "**(You pick up the notebook from the box. It looks old but unused, as if waiting for someone to fill its pages.)**",
            "**(A small note inside reads: 'Write here, morning and night. Your words will nourish what has been given to you.')**",
            "**(Somehow, you get the feeling that recording your thoughts each day might be more important than it seems.)**"
        ]

    static let journalPrompt = "Would you like to record today’s journal?"
    
    static func getGreeting(for hour: Int) -> String {
        return greetings[hour < 12 ? 0 : (hour < 18 ? 1 : 2)]
    }

}

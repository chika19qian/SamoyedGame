//
//  Dialogues.swift
//  Samoedo
//
//  Created by chika on 2025/2/8.
//

import Foundation

struct DialogueLine {
    let speaker: String  // 角色名
    let message: String  // 对话内容
}

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
    
    static let story: [DialogueLine] = [
        // 🎭 Discovering the Mysterious Box
        DialogueLine(speaker: "Narration", message: "(You discover a softly glowing wooden box in the corner, with a yellowed label attached)"),
        DialogueLine(speaker: "Note", message: "『To the Chosen One: This is a gift from the Wizard Olivia. The little one inside has chosen you.』"),
        DialogueLine(speaker: "Narration", message: "(You carefully open the box to find a puppy sleeping inside. A magical tag floats above its collar)"),
        
        // 🐾 First Meeting
        DialogueLine(speaker: "Note", message: "『(The puppy opens its eyes, looking at you curiously. Its ears twitch gently)』"),
        DialogueLine(speaker: "Note", message: "『(It stands up, cautiously approaching you. New tags appear in the air)』"),
        DialogueLine(speaker: "Note", message: "『This puppy comes from the Wizard's Nursery. It needs a warm home and a loving owner.』"),
        DialogueLine(speaker: "Narration", message: "(The puppy starts wagging its tail softly, as a new tag forms in the air)"),
        
        // 🏷️ Magical Tags
        DialogueLine(speaker: "Note", message: "『The Wizard says: Give it a name, and this will forge an eternal bond between you.』"),
        // Wait for player to input name
        DialogueLine(speaker: "Note", message: "『(The puppy spins in circles excitedly at its new name, the writing on the tag begins to glow)』"),
        DialogueLine(speaker: "Note", message: "『It is now {dogName}! The magical contract is sealed.』"),
        
        // 📖 The Magic Diary
        DialogueLine(speaker: "Narration", message: "(A light blue notebook with star patterns on its cover appears at the bottom of the box)"),
        DialogueLine(speaker: "Note", message: "『(The puppy gently nudges the notebook with its nose, sending ripples of light across its surface)』"),
        DialogueLine(speaker: "Note", message: "『This is the Magical Growth Diary. Your daily entries will transform into nourishment that {dogName} needs to grow.』"),
        DialogueLine(speaker: "Note", message: "『Write down happy memories to make the dog food more delicious; record warm moments to help {dogName} grow healthier.』"),
        
        // 🌟 A New Beginning
        DialogueLine(speaker: "Narration", message: "(The puppy snuggles against your feet as one final tag slowly materializes above its collar)"),
        DialogueLine(speaker: "Note", message: "『May your story be filled with laughter. Take good care of this little one — Wizard Olivia』"),
        DialogueLine(speaker: "Note", message: "『(The puppy happily nuzzles your hand, its eyes sparkling with trust)』"),
        DialogueLine(speaker: "Narration", message: "(This is the beginning of your story with {dogName}.)")
    ]
    static let journalPrompt = "Would you like to record today’s journal?"
    
    static func getGreeting(for hour: Int) -> String {
        return greetings[hour < 12 ? 0 : (hour < 18 ? 1 : 2)]
    }

}




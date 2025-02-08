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
        // 🐾 盒子里的小家伙
        DialogueLine(speaker: "puppy", message: "…Oh! Uh… h-hi? (It blinks up at you, ears twitching nervously.)"),
        DialogueLine(speaker: "puppy", message: "I… I woke up here. In this box. And then—poof!—you showed up! Did you… put me here?"),
        DialogueLine(speaker: "puppy", message: "No? Oh. Then… do you know where I came from? (It tilts its head, looking hopeful.)"),
        DialogueLine(speaker: "Narration", message: "(You shake your head. The puppy’s tail droops slightly but starts wagging again.)"),
        DialogueLine(speaker: "puppy", message: "I see… So, uh… what happens now? (It shuffles its paws uncertainly.)"),

        // 🐶 取名字
        DialogueLine(speaker: "puppy", message: "Wait, wait! Before anything else… Do I have a name? (It suddenly perks up, eyes wide.)"),
        DialogueLine(speaker: "puppy", message: "Oh no… what if I don’t? What if I’m just… ‘puppy’ forever?!"),
        DialogueLine(speaker: "Narration", message: "(You kneel down and stroke its soft fur. It tenses for a moment, then leans into your hand.)"),
        DialogueLine(speaker: "puppy", message: "Ah… that feels nice. Okay! If I don’t have a name, can you… can you give me one?"),
        // 这里等待用户输入名字
        DialogueLine(speaker: "{dogName}", message: "…Oh! Oh! That’s my name?! I have a name now! Say it again! Say it one more time!"),
        DialogueLine(speaker: "Narration", message: "(You repeat it, and the puppy’s tail wags so hard it nearly topples over.)"),
        DialogueLine(speaker: "{dogName}", message: "Hehehe! It sounds warm. Like sunshine! That means… I’m real, right? I’m *really* here?"),
        DialogueLine(speaker: "{dogName}", message: "And if I have a name… does that mean I’m yours? (Its voice is small, uncertain, but hopeful.)"),
        DialogueLine(speaker: "Narration", message: "(You nod. The puppy's ears shoot up, and it practically vibrates with excitement.)"),
        DialogueLine(speaker: "{dogName}", message: "Then I’ll stay with you forever! That’s how it works, right? If you name something, you keep it?"),
        DialogueLine(speaker: "Narration", message: "(It leaps into your lap, paws flailing clumsily, as if trying to hug you.)"),

        // 📖 发现日记本
        DialogueLine(speaker: "Narration", message: "(As you adjust your grip, you notice something else in the box—an old notebook. The puppy notices too, sniffing at it curiously.)"),
        DialogueLine(speaker: "{dogName}", message: "Ooh, what’s that? A snack? No, wait… it smells like paper! But also like… you?"),
        DialogueLine(speaker: "Narration", message: "(You pick up the notebook. There's a folded note inside. You open it.)"),
        DialogueLine(speaker: "Note", message: "✧ \"Write here, morning and night. Your words will nourish what has been given to you.\""),
        DialogueLine(speaker: "Narration", message: "(The handwriting is neat, careful, but unfamiliar.)"),
        DialogueLine(speaker: "{dogName}", message: "Ohhh, you have to write in it? So it’s like… a magic book?"),
        DialogueLine(speaker: "{dogName}", message: "Maybe it’s important! Maybe it’s a clue! Maybe if you write in it, something amazing will happen!"),
        DialogueLine(speaker: "{dogName}", message: "Uhm… if you do write in it… will you write about me too?"),
        DialogueLine(speaker: "Narration", message: "(The puppy waits for your answer, tail wagging slowly, eyes filled with quiet hope.)")
    ]

    static let journalPrompt = "Would you like to record today’s journal?"
    
    static func getGreeting(for hour: Int) -> String {
        return greetings[hour < 12 ? 0 : (hour < 18 ? 1 : 2)]
    }

}




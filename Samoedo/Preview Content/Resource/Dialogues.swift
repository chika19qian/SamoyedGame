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

// Daily Dialogues
struct Dialogues {

    static let messages = [
        "Woof!", "Wooooooooof!", "WOOOOOOF!",
        "woof woof!", "Woof?",
        "Woof..."
    ]
    
    static let puppyHappy = ["Woof woof!", "Yip! Yip!", "(wags tail) Woof!", "(Excited tail wagging) Arf! Arf!", "(Spinning in circles) Awoo~!"]
    static let puppyHungry = ["Wh... woof?", "(stares at food bowl) Woof...", "Woof... (stomach rumbles)", "(Looking at diary then bowl) Arf?"]
    
    static let youngHappy = ["I like you! Woof!", "Wanna play? Woof!", "Let's go outside!", "H-happy! Woof!", "Fun! Joy! Love!"]
    static let youngHungry = ["Woof... I'm kinda hungry.", "I think it's snack time... woof.", "(puppy eyes) Food soon?", "Food song time?"]
    
    static let adultHappy = ["You're the best! ❤️", "Let's go for a walk!", "I love you, hooman!","(Creating light patterns) Look what I learned!", "(Dancing with magical trails) Adventure time?", "We're perfect together! 🌟"]
    static let adultHungry = ["I'm starving... Can we eat now?", "Time for dinner? Please?", "I would LOVE some food right now!", "The magic requires sustenance... and treats! ✨"]

    static var lastEmotionReaction: String? = nil

    static func getDialogue(for stage: String, hunger: String, emotionScore: Int) -> String {
        let baseDialogue = getBaseDialogue(for: stage, hunger: hunger)
        let emotionReaction = getEmotionReaction(for: stage, emotionScore: emotionScore)

        let allDialogues =  [baseDialogue, emotionReaction]

        return allDialogues.randomElement() ?? "🐶 *blinks curiously*"

    }


    
    static func getBaseDialogue(for stage: String, hunger: String) -> String {
        switch stage {
        case "Puppy":
            return (hunger == "Hungry") ? puppyHungry.randomElement()! : puppyHappy.randomElement()!
        case "Young":
            return (hunger == "Hungry") ? youngHungry.randomElement()! : youngHappy.randomElement()!
        case "Adult":
            return (hunger == "Hungry") ? adultHungry.randomElement()! : adultHappy.randomElement()!
        default:
            return "🐶 Woof?"
        }
    }
 
    static func getEmotionReaction(for stage: String, emotionScore: Int) -> String {
        switch stage {
        case "Puppy":
            return getPuppyEmotionReaction(emotionScore)
        case "Young":
            return getYoungEmotionReaction(emotionScore)
        case "Adult":
            return getAdultEmotionReaction(emotionScore)
        default:
            return "(tilts head) How are you feeling?"
        }
    }

    private static func getPuppyEmotionReaction(_ emotionScore: Int) -> String {
        let reactions: [String]
        switch emotionScore {
        case 1:
            reactions = [
                "(whines and snuggles up to you)",
                "(whimpers softly and nudges you)",
                "(curls up beside you quietly)"
            ]
        case 2:
            reactions = [
                "(nudges your hand and licks it softly)",
                "(rests head on your knee)",
                "(gives you big puppy eyes)"
            ]
        case 3:
            reactions = [
                "(wag wag!)",
                "(tilts head curiously)",
                "(barks softly)"
            ]
        case 4:
            reactions = [
                "(jumps around excitedly) Woof woof!",
                "(paws at you playfully)",
                "(does a little happy dance)"
            ]
        case 5:
            reactions = [
                "So much fun!!!",
                "(zoomies around the room)",
                "(spins in circles excitedly)"
            ]
        default:
            reactions = [
                "(tilts head) Woof?",
                "(looks at you expectantly)",
                "(wiggles tail slightly)"
            ]
        }
        return reactions.randomElement() ?? "(tilts head) Woof?"
    }

    private static func getYoungEmotionReaction(_ emotionScore: Int) -> String {
        let reactions: [String]
        switch emotionScore {
        case 1:
            reactions = [
                "(rests head on your lap) I’m here for you!",
                "(sits close to you silently)",
                "(lays down beside you, ears drooping)"
            ]
        case 2:
            reactions = [
                "(nudges you) Let's do something fun!",
                "(barks softly) Want to play?",
                "(sits beside you wagging its tail)"
            ]
        case 3:
            reactions = [
                "(tail wagging) You seem okay! Wanna play?",
                "(ears perk up) What’s next?",
                "(tilts head and barks playfully)"
            ]
        case 4:
            reactions = [
                "(bounces happily) You're feeling great! Let's go outside!",
                "(wags tail excitedly) Wanna go for a run?",
                "(spins in circles) Let’s have fun!"
            ]
        case 5:
            reactions = [
                "(runs in circles) Yay! You look super happy!",
                "(excited jumps) Let's play!",
                "(barks happily) I love this energy!"
            ]
        default:
            reactions = [
                "How are you?",
                "(tilts head, curious)",
                "(sits quietly, waiting)"
            ]
        }
        return reactions.randomElement() ?? "How are you?"
    }


    private static func getAdultEmotionReaction(_ emotionScore: Int) -> String {
        let reactions: [String]
        switch emotionScore {
        case 1:
            reactions = [
                "I'm here for you, buddy. Want a hug?",
                "(sits beside you quietly) You can talk to me.",
                "(lays head on your lap) It’s okay, I’m here."
            ]
        case 2:
            reactions = [
                "You seem a little off today. Let’s take it easy!",
                "If you need a break, I'm here for you.",
                "Let's just relax together, okay?"
            ]
        case 3:
            reactions = [
                "You're doing fine! Let’s have a good day together!",
                "Let’s take things at your pace.",
                "Everything’s going well, let’s keep it up!"
            ]
        case 4:
            reactions = [
                "You're feeling great! Maybe we should go for a walk?",
                "Let’s make the most of today!",
                "You have good energy! Let’s do something fun!"
            ]
        case 5:
            reactions = [
                "You're super happy! I love seeing you like this!",
                "This is awesome! Let’s enjoy the moment!",
                "(barks happily) You seem so excited!"
            ]
        default:
            reactions = [
                "Hey, how are you?",
                "(tilts head, curious)",
                "(sits calmly, wagging tail)"
            ]
        }
        return reactions.randomElement() ?? "Hey, how are you?"
    }

    
    
// FIRST Story
    static let story: [DialogueLine] = [
        // 🎭 Discovering the Mysterious Box
        DialogueLine(speaker: "Narration", message: "(You discover a softly glowing wooden box in the corner, with a yellow note attached)"),
        DialogueLine(speaker: "Note", message: "『To the Chosen One: This is a gift from the Wizard Olivia. The little one inside has chosen you.』"),
        DialogueLine(speaker: "Narration", message: "(You carefully open the box to find a puppy inside. A magical tag floats above its collar)"),
        
        // 🐾 First Meeting
        DialogueLine(speaker: "Narration", message: "(The puppy stands up, looking at you curiously. Its ears twitch gently)"),
        DialogueLine(speaker: "Narration", message: "(New tags appear in the air)"),
        DialogueLine(speaker: "Note", message: "『This puppy comes from the Wizard's Nursery. It needs a warm home and a loving owner.』"),
        DialogueLine(speaker: "Narration", message: "(The puppy starts wagging its tail softly, as a new tag forms in the air)"),
        
        // 🏷️ Magical Tags
        DialogueLine(speaker: "Note", message: "『The Wizard says: Give it a name, and this will forge an eternal bond between you.』"),
        // Wait for player to input name
        DialogueLine(speaker: "Note", message: "『(The puppy spins in circles excitedly at its new name, the writing on the tag begins to glow)』"),
        DialogueLine(speaker: "Note", message: "『It is now {dogName}! The magical contract is sealed.』"),
        DialogueLine(speaker: "{dogName}", message: "Woof!"),
        
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
    


}




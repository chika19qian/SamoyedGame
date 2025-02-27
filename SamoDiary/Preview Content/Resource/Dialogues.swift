//
//  Dialogues.swift
//  SamoDiary
//
//  Created by chika on 2025/2/8.
//

import Foundation

struct DialogueLine {
    let speakerKey: String
    let messageKey: String
    func localized(dogName: String) -> (speaker: String, message: AttributedString) {
        let speaker = String(format: NSLocalizedString(speakerKey, comment: ""), dogName)
        let rawMessage = String(format: NSLocalizedString(messageKey, comment: ""), dogName)

        let formattedMessage = rawMessage.replacingOccurrences(of: "{dogName}", with: "{bold}\(dogName){bold}")

        let attributedMessage = TextFormatter.parse(formattedMessage)

        return (speaker, attributedMessage)
    }
}



// Daily Dialogues
struct Dialogues {

    static let messages = [
        String(localized: "Woof!"), String(localized: "Wooooooooof!"), String(localized: "WOOOOOOF!"),
        String(localized: "woof woof!"), String(localized: "Woof?"),
        String(localized: "Woof...")
    ]

    static let puppyHappy = [
        String(localized: "Woof woof!"), String(localized: "Yip! Yip!"), String(localized: "(wags tail) Woof!"),
        String(localized: "(Excited tail wagging) Arf! Arf!"), String(localized: "(Spinning in circles) Awoo~!")
    ]

    static let puppyHungry = [
        String(localized: "Wh... woof?"), String(localized: "(stares at food bowl) Woof..."),
        String(localized: "Woof... (stomach rumbles)"), String(localized: "(Looking at diary then bowl) Arf?")
    ]

    static let youngHappy = [
        String(localized: "I like you! Woof!"), String(localized: "Wanna play? Woof!"),
        String(localized: "Let's go outside!"), String(localized: "H-happy! Woof!"), String(localized: "Fun! Joy! Love!")
    ]

    static let youngHungry = [
        String(localized: "Woof... I'm kinda hungry."), String(localized: "I think it's snack time... woof."),
        String(localized: "(puppy eyes) Food soon?"), String(localized: "Food song time?")
    ]

    static let adultHappy = [
        String(localized: "You're the best! ❤️"), String(localized: "Let's go for a walk!"),
        String(localized: "I love you, hooman!"), String(localized: "(Creating light patterns) Look what I learned!"),
        String(localized: "(Dancing with magical trails) Adventure time?"), String(localized: "We're perfect together! 🌟")
    ]

    static let adultHungry = [
        String(localized: "I'm starving... Can we eat now?"), String(localized: "Time for dinner? Please?"),
        String(localized: "I would LOVE some food right now!"), String(localized: "The magic requires sustenance... and treats! ✨")
    ]


    static var lastEmotionReaction: String? = nil

    static func getDialogue(for stage: String, hunger: String, emotionScore: Int) -> String {
        let baseDialogue = getBaseDialogue(for: stage, hunger: hunger)
        let emotionReaction = getEmotionReaction(for: stage, emotionScore: emotionScore)

        let allDialogues =  [baseDialogue, emotionReaction]

        return allDialogues.randomElement() ?? "～"

    }


    
    static func getBaseDialogue(for stage: String, hunger: String) -> String {
        switch stage {
        case String(localized: "Puppy"):
            return (hunger == "Hungry") ? puppyHungry.randomElement()! : puppyHappy.randomElement()!
        case String(localized: "Young"):
            return (hunger == "Hungry") ? youngHungry.randomElement()! : youngHappy.randomElement()!
        case String(localized: "Adult"):
            return (hunger == "Hungry") ? adultHungry.randomElement()! : adultHappy.randomElement()!
        default:
            return "Woof?"
        }
    }
 
    static func getEmotionReaction(for stage: String, emotionScore: Int) -> String {
        switch stage {
        case String(localized: "Puppy"):
            return getPuppyEmotionReaction(emotionScore)
        case String(localized: "Young"):
            return getYoungEmotionReaction(emotionScore)
        case String(localized: "Adult"):
            return getAdultEmotionReaction(emotionScore)
        default:
            return String(localized: "(tilts head) How are you feeling?")
        }
    }

    private static func getPuppyEmotionReaction(_ emotionScore: Int) -> String {
        let reactions: [String]
        switch emotionScore {
        case 1:
            reactions = [
                String(localized: "(whines and snuggles up to you)"),
                String(localized: "(whimpers softly and nudges you)"),
                String(localized: "(curls up beside you quietly)")
            ]
        case 2:
            reactions = [
                String(localized: "(nudges your hand and licks it softly)"),
                String(localized: "(rests head on your knee)"),
                String(localized: "(gives you big puppy eyes)")
            ]
        case 3:
            reactions = [
                String(localized: "(wag wag!)"),
                String(localized: "(tilts head curiously)"),
                String(localized: "(barks softly)")
            ]
        case 4:
            reactions = [
                String(localized: "(jumps around excitedly) Woof woof!"),
                String(localized: "(paws at you playfully)"),
                String(localized: "(does a little happy dance)")
            ]
        case 5:
            reactions = [
                String(localized: "So much fun!!!"),
                String(localized: "(zoomies around the room)"),
                String(localized: "(spins in circles excitedly)")
            ]
        default:
            reactions = [
                String(localized: "(tilts head) Woof?"),
                String(localized: "(looks at you expectantly)"),
                String(localized: "(wiggles tail slightly)")
            ]
        }
        return reactions.randomElement() ?? String(localized: "(tilts head) Woof?")
    }

    private static func getYoungEmotionReaction(_ emotionScore: Int) -> String {
        let reactions: [String]
        switch emotionScore {
        case 1:
            reactions = [
                String(localized: "Long press, meditation 🧘‍♂️"),
                String(localized: "(rests head on your lap) I’m here for you!"),
                String(localized: "(sits close to you silently)"),
                String(localized: "(lays down beside you, ears drooping)")
            ]
        case 2:
            reactions = [
                String(localized: "Long press, meditation 🧘‍♂️"),
                String(localized: "(nudges you) Let's do something fun!"),
                String(localized: "(barks softly) Want to play?"),
                String(localized: "(sits beside you wagging its tail)")
            ]
        case 3:
            reactions = [
                String(localized: "(tail wagging) You seem okay! Wanna play?"),
                String(localized: "(ears perk up) What’s next?"),
                String(localized: "(tilts head and barks playfully)")
            ]
        case 4:
            reactions = [
                String(localized: "(bounces happily) You're feeling great! Let's go outside!"),
                String(localized: "(wags tail excitedly) Wanna go for a run?"),
                String(localized: "(spins in circles) Let’s have fun!")
            ]
        case 5:
            reactions = [
                String(localized: "(runs in circles) Yay! You look super happy!"),
                String(localized: "(excited jumps) Let's play!"),
                String(localized: "(barks happily) I love this energy!")
            ]
        default:
            reactions = [
                String(localized: "How are you?"),
                String(localized: "(tilts head, curious)"),
                String(localized: "(sits quietly, waiting)")
            ]
        }
        return reactions.randomElement() ?? String(localized: "How are you?")
    }


    private static func getAdultEmotionReaction(_ emotionScore: Int) -> String {
        let reactions: [String]
        switch emotionScore {
        case 1:
            reactions = [
                String(localized: "You seem a bit down... Want to try meditating together? 🧘‍♂️"),
                String(localized: "I'm here for you, buddy. Want a hug?"),
                String(localized: "(sits beside you quietly) You can talk to me."),
                String(localized: "(lays head on your lap) It’s okay, I’m here.")
            ]
        case 2:
            reactions = [
                String(localized: "You seem a bit down... Want to try meditating together? 🧘‍♂️"),
                String(localized: "You seem a little off today. Let’s take it easy!"),
                String(localized: "If you need a break, I'm here for you."),
                String(localized: "Let's just relax together, okay?")
            ]
        case 3:
            reactions = [
                String(localized: "You're doing fine! Let’s have a good day together!"),
                String(localized: "Let’s take things at your pace."),
                String(localized: "Everything’s going well, let’s keep it up!")
            ]
        case 4:
            reactions = [
                String(localized: "You're feeling great! Maybe we should go for a walk?"),
                String(localized: "Let’s make the most of today!"),
                String(localized: "You have good energy! Let’s do something fun!")
            ]
        case 5:
            reactions = [
                String(localized: "You're super happy! I love seeing you like this!"),
                String(localized: "This is awesome! Let’s enjoy the moment!"),
                String(localized: "(barks happily) You seem so excited!")
            ]
        default:
            reactions = [
                String(localized: "Hey, how are you?"),
                String(localized: "(tilts head, curious)"),
                String(localized: "(sits calmly, wagging tail)")
            ]
        }
        return reactions.randomElement() ?? String(localized: "Hey, how are you?")
    }


    
    
// FIRST Story
    static let story: [DialogueLine] = [
        // 🎭 Discovering the Mysterious Box
        DialogueLine(speakerKey: "narration", messageKey: "(You discover a softly glowing wooden box in the corner, with a yellow note attached)"),
        DialogueLine(speakerKey: "note", messageKey: "To the Chosen One: This is a gift from the Wizard Olivia. The little one inside has chosen you."),
        DialogueLine(speakerKey: "narration", messageKey: "(You carefully open the box to find a {bold}puppy{bold} inside. A magical tag floats above its collar)"),
        
        // 🐾 First Meeting
        DialogueLine(speakerKey: "narration", messageKey: "(The puppy stands up, looking at you curiously. Its ears twitch gently)"),
        DialogueLine(speakerKey: "narration", messageKey: "(New tags appear in the air)"),
        DialogueLine(speakerKey: "note", messageKey: "This puppy comes from the Wizard's Nursery. It needs a warm home and a loving owner."),
        DialogueLine(speakerKey: "narration", messageKey: "(The puppy starts wagging its tail softly, as a new tag forms in the air)"),
        
        // 🏷️ Magical Tags
        DialogueLine(speakerKey: "note", messageKey: "The Wizard says: {bold}Give it a name{bold}, and this will forge an eternal bond between you."),
        DialogueLine(speakerKey: "note", messageKey: "(The puppy spins in circles excitedly at its new name, the writing on the tag begins to glow)"),
        DialogueLine(speakerKey: "note", messageKey: "It is now {dogName}! The magical contract is sealed."),
        DialogueLine(speakerKey: "dogName", messageKey: "Woof!"),
        
        // 📖 The Magic Diary
        DialogueLine(speakerKey: "narration", messageKey: "(A brown notebook appears at the bottom of the box)"),
        DialogueLine(speakerKey: "note", messageKey: "(The puppy gently nudges the notebook with its nose, sending ripples of light across its surface)"),
        DialogueLine(speakerKey: "note", messageKey: "This is the Magical Growth Diary. Your daily entries will transform into nourishment that {dogName} needs to grow."),
        DialogueLine(speakerKey: "note", messageKey: "Write down happy memories to make the dog food more delicious; record warm moments to help {dogName} grow healthier."),
        
        // 🌟 A New Beginning
        DialogueLine(speakerKey: "narration", messageKey: "(The puppy snuggles against your feet as one final tag slowly materializes above its head)"),
        DialogueLine(speakerKey: "note", messageKey: "May your story be filled with laughter. Take good care of this little one — Wizard Olivia"),
        DialogueLine(speakerKey: "note", messageKey: "(The puppy happily nuzzles your hand, its eyes sparkling with trust)"),
        DialogueLine(speakerKey: "narration", messageKey: "(This is the beginning of your story with {dogName}.)"),
    ]

    static let journalPrompt = String(localized: "Would you like to record today’s journal?")
    
    static let tutorial: [DialogueLine] = [
        DialogueLine(speakerKey: "note", messageKey: NSLocalizedString("tutorial_step_1", comment: "")),
        DialogueLine(speakerKey: "note", messageKey: NSLocalizedString("tutorial_step_2", comment: "")),
        DialogueLine(speakerKey: "note", messageKey: NSLocalizedString("tutorial_step_3", comment: "")),
        DialogueLine(speakerKey: "note", messageKey: NSLocalizedString("tutorial_step_4", comment: "")),
        DialogueLine(speakerKey: "note", messageKey: NSLocalizedString("tutorial_step_5", comment: "")),
        DialogueLine(speakerKey: "note", messageKey: NSLocalizedString("tutorial_step_6", comment: ""))
    ]




}






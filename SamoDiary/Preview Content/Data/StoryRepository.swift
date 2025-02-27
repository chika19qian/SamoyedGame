//
//  StoryRepository.swift
//  SamoDiary
//
//  Created by chika on 2025/2/8.
//

import Foundation

class StoryRepository {
    
    private let hasSeenOpeningKey = "HasSeenOpening"
    private let userDefaults = UserDefaults.standard
    private let hasSeenTutorialKey = "HasSeenTutorial"

    func hasSeenTutorial() -> Bool {
        return userDefaults.bool(forKey: hasSeenTutorialKey)
    }

    func setSeenTutorial() {
        userDefaults.set(true, forKey: hasSeenTutorialKey)
        userDefaults.synchronize()
    }
    
    func hasSeenOpening() -> Bool {
        let seen = userDefaults.bool(forKey: hasSeenOpeningKey)
        print("🔍 storyRepository.hasSeenOpening() -> \(seen)")
        return seen
    }
    
    func setSeenOpening() {
        print("～～～～～～～～～")
        userDefaults.set(true, forKey: hasSeenOpeningKey)
        userDefaults.synchronize()
        
        let savedValue = userDefaults.bool(forKey: hasSeenOpeningKey)
        print("✅ storyRepository.setSeenOpening() -> Opening scene marked as seen, UserDefaults: \(savedValue)")
    }
}

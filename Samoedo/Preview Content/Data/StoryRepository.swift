//
//  StoryRepository.swift
//  Samoedo
//
//  Created by chika on 2025/2/8.
//

import Foundation

class StoryRepository {
    
    private let hasSeenOpeningKey = "HasSeenOpening"
    private let userDefaults = UserDefaults.standard
    
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

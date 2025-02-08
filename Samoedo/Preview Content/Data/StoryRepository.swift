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
        return userDefaults.bool(forKey: hasSeenOpeningKey)
    }
    
    func setSeenOpening() {
        userDefaults.set(true, forKey: hasSeenOpeningKey)
    }
}

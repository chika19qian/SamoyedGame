//
//  SettingsRepository.swift
//  SamoDiary
//
//  Created by chika on 2025/2/28.
//

import Foundation
import Combine

class SettingsRepository: ObservableObject {
    static let shared = SettingsRepository()
    
    @Published var selectedLanguage: String {
        didSet {
            UserDefaults.standard.set(selectedLanguage, forKey: "appLanguage")
            UserDefaults.standard.set([selectedLanguage], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            print("🔄 Language changed to: \(selectedLanguage)")
        }
    }
    
    private init() {
        let systemLanguage = Locale.preferredLanguages.first ?? "en"
        
        if systemLanguage.starts(with: "zh") {
            self.selectedLanguage = "zh-Hans"
        }  else {
            self.selectedLanguage = "en"
        }

        if let savedLanguage = UserDefaults.standard.string(forKey: "appLanguage") {
            self.selectedLanguage = savedLanguage
        }
    }

    
    func setAppLanguage(_ language: String) {
        selectedLanguage = language
    }
}

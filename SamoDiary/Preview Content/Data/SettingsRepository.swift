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
        self.selectedLanguage = UserDefaults.standard.string(forKey: "appLanguage") ?? Locale.current.identifier
    }
    
    func setAppLanguage(_ language: String) {
        selectedLanguage = language
    }
}

//
//  AudioRepository.swift
//  Samoedo
//
//  Created by chika on 2025/2/25.
//

import Foundation

class AudioRepository {
    static let shared = AudioRepository()

    private let selectedBGMKey = "SelectedBGM"
    private let selectedMeditationKey = "SelectedMeditation"
    private let isBGMPlayingKey = "IsBGMPlaying"

    private init() {}


    func saveSelectedBGM(_ filename: String) {
        UserDefaults.standard.set(filename, forKey: selectedBGMKey)
    }


    func getSelectedBGM() -> String {
        return UserDefaults.standard.string(forKey: selectedBGMKey) ?? AudioLibrary.bgmMain
    }


    func saveSelectedMeditation(_ filename: String) {
        UserDefaults.standard.set(filename, forKey: selectedMeditationKey)
    }


    func getSelectedMeditation() -> String {
        return UserDefaults.standard.string(forKey: selectedMeditationKey) ?? AudioLibrary.meditationCalm
    }
    
    func playBGM(filename: String? = nil) {
        let bgmToPlay = filename ?? getSelectedBGM()
        AudioManager.shared.playBGM(filename: bgmToPlay)
    }
    

    func playMeditation(filename: String? = nil) {
        let meditationToPlay = filename ?? getSelectedMeditation()
        MeditationAudioManager.shared.playMeditation(filename: meditationToPlay)
    }
    
    func saveBGMPlayingState(_ isPlaying: Bool) {
        UserDefaults.standard.set(isPlaying, forKey: isBGMPlayingKey)
    }


    func isBGMPlaying() -> Bool {
        return UserDefaults.standard.bool(forKey: isBGMPlayingKey)
    }

}

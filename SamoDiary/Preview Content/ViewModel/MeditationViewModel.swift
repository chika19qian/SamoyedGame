//
//  MeditationViewModel.swift
//  SamoDiary
//
//  Created by chika on 2025/2/22.
//

import Foundation
import SwiftUI
import AVFoundation
import Combine

class MeditationViewModel: ObservableObject {
    @Published var duration: Double = 1.0
    @Published var progress: Double = 0.0
    @Published var isPlaying: Bool = false
    @Published var selectedMeditationTitle: String = ""

    private var playerObserver: AnyCancellable?

    init() {
        selectedMeditationTitle = AudioRepository.shared.getSelectedMeditation()
    }
    

    func setupAudio() {
        AudioManager.shared.stopBGM()
        MeditationAudioManager.shared.playMeditation(filename: selectedMeditationTitle)
        
        isPlaying = MeditationAudioManager.shared.player?.isPlaying ?? false
        print("🎵 Meditation Started: \(isPlaying)")
        
        playerObserver = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateProgress()
            }
    }

    private func updateProgress() {
        if let player = MeditationAudioManager.shared.player {
            progress = player.currentTime / max(player.duration, 1)  // `currentTime` 直接是 Double
            duration = max(player.duration, 1)
            isPlaying = player.isPlaying 
        }
    }


    func togglePlayPause() {
        guard let player = MeditationAudioManager.shared.player else { return }
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        print("🎵 Toggle Play State: \(isPlaying)")
    }
    
    func playNextMeditation() {
        MeditationAudioManager.shared.playNextMeditation()
        selectedMeditationTitle = AudioRepository.shared.getSelectedMeditation()
    }

    func playPreviousMeditation() {
        MeditationAudioManager.shared.playPreviousMeditation()
        selectedMeditationTitle = AudioRepository.shared.getSelectedMeditation()  
    }
    
    func seekToTime(_ time: Double) {
        guard let player = MeditationAudioManager.shared.player else { return }
        player.currentTime = time
    }

    
    func stopMeditation() {
        MeditationAudioManager.shared.stopMeditation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let lastSelectedBGM = AudioRepository.shared.getSelectedBGM()
            let shouldPlayBGM = AudioRepository.shared.isBGMPlaying()

            if shouldPlayBGM {
                AudioManager.shared.playBGM(filename: lastSelectedBGM)  
                print("🎵 冥想结束，恢复 BGM: \(lastSelectedBGM)")
            } else {
                print("🔇 用户之前暂停了 BGM，不恢复")
            }
        }
    }


}





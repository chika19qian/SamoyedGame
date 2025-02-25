//
//  MeditationViewModel.swift
//  Samoedo
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
    @Published var isMeditationFinished = false

    private var playerObserver: AnyCancellable?

    init() {
    }
    

    func setupAudio() {
        AudioManager.shared.stopBGM()
        MeditationAudioManager.shared.playMeditation(filename: "meditation_audio")
        
        isPlaying = MeditationAudioManager.shared.player?.isPlaying ?? false // 确保状态正确
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

    
    func forward5s() {
        guard let player = MeditationAudioManager.shared.player else { return }
        let newTime = min(player.currentTime + 5, player.duration)
        player.currentTime = newTime
    }

    func backward5s() {
        guard let player = MeditationAudioManager.shared.player else { return }
        let newTime = max(player.currentTime - 5, 0)
        player.currentTime = newTime
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





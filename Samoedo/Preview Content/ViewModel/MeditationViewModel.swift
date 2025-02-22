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

    private var player: AVPlayer?
    private var playerObserver: AnyCancellable?

    init() {
    }
    
    private func setupAudio() {
        AudioManager.shared.stopBGM()
        MeditationAudioManager.shared.playMeditation(filename: "meditation_audio")
        

        playerObserver = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self, let player = self.player, let currentItem = player.currentItem else { return }
                self.progress = player.currentTime().seconds / currentItem.duration.seconds
                self.duration = currentItem.duration.seconds
            }
    }


    func togglePlayPause() {
        guard let player = player else { return }
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
    }

    
    func forward5s() {
        guard let player = player else { return }
        let currentTime = player.currentTime().seconds
        let newTime = min(currentTime + 5, duration)
        player.seek(to: CMTime(seconds: newTime, preferredTimescale: 1))
    }


    func backward5s() {
        guard let player = player else { return }
        let currentTime = player.currentTime().seconds
        let newTime = max(currentTime - 5, 0)
        player.seek(to: CMTime(seconds: newTime, preferredTimescale: 1))
    }
    
    func stopMeditation() {
        MeditationAudioManager.shared.stopMeditation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // 延迟 0.5 秒后播放 BGM
            AudioManager.shared.playBGM(filename: "main_bgm")
        }
    }

}





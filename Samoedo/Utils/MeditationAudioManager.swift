//
//  MeditationAudioManager.swift
//  Samoedo
//
//  Created by chika on 2025/2/22.
//

import AVFoundation

class MeditationAudioManager {
    static let shared = MeditationAudioManager()
    var player: AVAudioPlayer?
    var meditationVolume: Double = 0.5

    private init() {}

    func playMeditation(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.volume = Float(meditationVolume)
            player?.play()

            print("🎵 Playing Meditation: \(filename)")
        } catch {
            print("❌ 冥想音频播放失败: \(error.localizedDescription)")
        }
    }



    func stopMeditation() {
        player?.stop()
    }

    func setMeditationVolume(_ volume: Double) {
        meditationVolume = volume
        player?.volume = Float(volume)
    }
    
    func playShortMeditationFeedback() {
        guard let player = player else {
            playMeditation(filename: AudioLibrary.meditationCalm) // 播放默认冥想音频
            return
        }

        let wasBGMPlaying = AudioManager.shared.bgmPlayer?.isPlaying ?? false
        if wasBGMPlaying {
            AudioManager.shared.pauseBGM()
        }

        let originalTime = player.currentTime
        player.currentTime = 0
        player.play()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            player.pause()
            player.currentTime = originalTime
            if wasBGMPlaying {
                AudioManager.shared.resumeBGM()
            }
        }
    }

}

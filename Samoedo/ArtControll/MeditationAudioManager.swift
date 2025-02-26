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
    private var currentMeditationIndex = 0

    private init() {}

    func playMeditation(filename: String? = nil) {
        let meditationToPlay = filename ?? AudioLibrary.meditationList[currentMeditationIndex]
        
        guard let url = Bundle.main.url(forResource: meditationToPlay, withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.volume = Float(meditationVolume)
            player?.play()

            // 存储当前播放的冥想音频
            AudioRepository.shared.saveSelectedMeditation(meditationToPlay)
            print("🎵 播放冥想音频: \(meditationToPlay)")
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
    
    func playNextMeditation() {
        currentMeditationIndex = (currentMeditationIndex + 1) % AudioLibrary.meditationList.count
        playMeditation(filename: AudioLibrary.meditationList[currentMeditationIndex])
    }

    func playPreviousMeditation() {
        currentMeditationIndex = (currentMeditationIndex - 1 + AudioLibrary.meditationList.count) % AudioLibrary.meditationList.count
        playMeditation(filename: AudioLibrary.meditationList[currentMeditationIndex])
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

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
        } catch { print("冥想音频播放失败") }
    }

    func stopMeditation() {
        player?.stop()
    }

    func setMeditationVolume(_ volume: Double) {
        meditationVolume = volume
        player?.volume = Float(volume)
    }
}

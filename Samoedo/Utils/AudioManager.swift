//
//  AudioManager.swift
//  Samoedo
//
//  Created by chika on 2025/2/22.
//

import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    private var bgmPlayer: AVAudioPlayer?
    var bgmVolume: Double = 0.5

    private init() { }

    func playBGM(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else {
            print("❌ No Found Audio: \(filename)")
            return
        }
        do {
            bgmPlayer = try AVAudioPlayer(contentsOf: url)
            bgmPlayer?.numberOfLoops = -1
            bgmPlayer?.volume = Float(bgmVolume)
            bgmPlayer?.play()
            print("🎵 BGM is playing: \(filename)")
        } catch {
            print("❌ BGM failed to play: \(error.localizedDescription)")
        }
    }
    
    func setBGMVolume(_ volume: Double) {
        bgmVolume = volume
        bgmPlayer?.volume = Float(volume)
    }

    func pauseBGM() {
        bgmPlayer?.pause()
        print("⏸️ BGM stopped")
    }


    func resumeBGM() {
        bgmPlayer?.play()
        print("▶️ BGM 继续播放")
    }


    func stopBGM() {
        bgmPlayer?.stop()
        bgmPlayer = nil
        print("⏹️ BGM 停止播放")
    }
}

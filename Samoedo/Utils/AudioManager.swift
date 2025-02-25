//
//  AudioManager.swift
//  Samoedo
//
//  Created by chika on 2025/2/22.
//

import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    var bgmPlayer: AVAudioPlayer?
    
    var bgmVolume: Double = 0.5
    var isBGMManuallyStopped: Bool = false
    private var currentBGMIndex = 0

    private init() { }

    func playBGM(filename: String? = nil) {
        let bgmToPlay = filename ?? AudioRepository.shared.getSelectedBGM()
        
        guard let url = Bundle.main.url(forResource: bgmToPlay, withExtension: "mp3") else {
            print("❌ No Found Audio: \(bgmToPlay)")
            return
        }
        do {
            bgmPlayer = try AVAudioPlayer(contentsOf: url)
            bgmPlayer?.numberOfLoops = -1
            bgmPlayer?.volume = Float(bgmVolume)

            // 🛑 只有当用户允许播放 BGM 时才播放
            if AudioRepository.shared.isBGMPlaying() {
                bgmPlayer?.play()
                print("🎵 Playing BGM: \(bgmToPlay)")
            }

            // 📌 存储选中的 BGM
            AudioRepository.shared.saveSelectedBGM(bgmToPlay)

        } catch {
            print("❌ BGM failed to play: \(error.localizedDescription)")
        }
    }

    func pauseBGM() {
        bgmPlayer?.pause()
        isBGMManuallyStopped = true
        AudioRepository.shared.saveBGMPlayingState(false)  // 📌 记录 BGM 已暂停
        print("⏸️ BGM Stopped")
    }

    func resumeBGM() {
        bgmPlayer?.play()
        isBGMManuallyStopped = false
        AudioRepository.shared.saveBGMPlayingState(true)  // 📌 记录 BGM 已恢复
        print("▶️ BGM Resumed")
    }


    func playNextBGM() {
        currentBGMIndex = (currentBGMIndex + 1) % AudioLibrary.bgmList.count
        playBGM(filename: AudioLibrary.bgmList[currentBGMIndex])
    }


    func playRemixBGM() {
        var newIndex = currentBGMIndex
        while newIndex == currentBGMIndex {
            newIndex = Int.random(in: 0..<AudioLibrary.bgmList.count)  
        }
        currentBGMIndex = newIndex
        playBGM(filename: AudioLibrary.bgmList[currentBGMIndex])
    }
    
    func playVolumeFeedback() {
        guard let player = bgmPlayer else { return }

        if player.isPlaying {
            print("🎛 调整 BGM 音量")
        } else {
            print("🔊 播放短暂反馈音")
            player.currentTime = 0
            player.play()

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                player.pause()
                print("⏸️ 反馈音停止")
            }
        }
    }


    func setBGMVolume(_ volume: Double) {
        bgmVolume = volume
        bgmPlayer?.volume = Float(volume)
    }



    func stopBGM() {
        bgmPlayer?.stop()
        bgmPlayer = nil
        isBGMManuallyStopped = true
        print("⏹️ BGM 停止播放")
    }
}

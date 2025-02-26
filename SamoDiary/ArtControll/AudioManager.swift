//
//  AudioManager.swift
//  SamoDiary
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
            print("❌ No Found Audio: \(bgmToPlay).mp3")
            return
        }
        
        do {
            bgmPlayer = try AVAudioPlayer(contentsOf: url)
            bgmPlayer?.numberOfLoops = -1
            bgmPlayer?.volume = Float(bgmVolume)
            bgmPlayer?.play()


            AudioRepository.shared.saveSelectedBGM(bgmToPlay)
            print("🎵 Playing BGM: \(bgmToPlay) ✅")

        } catch {
            print("❌ BGM failed to play: \(error.localizedDescription)")
        }
    }


    func pauseBGM() {
        bgmPlayer?.pause()
        isBGMManuallyStopped = true
        AudioRepository.shared.saveBGMPlayingState(false)
        print("⏸️ BGM Stopped")
    }

    func resumeBGM() {
        if bgmPlayer == nil {
            let selectedBGM = AudioRepository.shared.getSelectedBGM()
            print("🎵 bgmPlayer 为空，重新加载 BGM: \(selectedBGM)")
            playBGM(filename: selectedBGM)
        } else {
            bgmPlayer?.play()
        }
        
        isBGMManuallyStopped = false
        AudioRepository.shared.saveBGMPlayingState(true)
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

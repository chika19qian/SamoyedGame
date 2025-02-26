//
//  SettingsView.swift
//  Samoedo
//
//  Created by chika on 2025/2/22.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var mvm: MainViewModel
    
    @State private var bgmVolume: Double = AudioManager.shared.bgmVolume
    @State private var meditationVolume: Double = MeditationAudioManager.shared.meditationVolume
    @State private var isBGMPlaying: Bool = AudioRepository.shared.isBGMPlaying()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            // 🌟 背景
            Color(red: 0.95, green: 0.9, blue: 0.78)
                .edgesIgnoringSafeArea(.all)

            VStack {
                // 🐶 标题
                Text("🐾 Settings")
                    .font(.custom("Chalkboard SE", size: 32))
                    .foregroundColor(.brown)
                    .padding()

                VStack(alignment: .leading, spacing: 8) {
                    Text("🎼 Background Music Volume")
                        .font(.custom("Chalkboard SE", size: 20))
                        .foregroundColor(.brown)

                    HStack {
                        Image(systemName: "speaker.fill")  // 🔊 低音量图标
                            .foregroundColor(.brown)

                        Slider(value: $bgmVolume, in: 0...1, step: 0.1)
                            .accentColor(.brown)
                            .onChange(of: bgmVolume) {
                                AudioManager.shared.setBGMVolume(bgmVolume)
                            }


                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundColor(.brown)
                    }.onChange(of: bgmVolume) {
                        AudioManager.shared.setBGMVolume(bgmVolume)
                        AudioManager.shared.playVolumeFeedback() 
                    }

                }
                .padding()
                
                HStack(spacing:30) {
                    Button(action: {
                        AudioManager.shared.playRemixBGM()
                    }) {
                        Image(systemName: "shuffle")
                            .font(.custom("Chalkboard SE", size: 23))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 55, height: 55)
                            .background(Color.brown.opacity(0.8))
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        if isBGMPlaying {
                            AudioManager.shared.pauseBGM()
                        } else {
                            AudioManager.shared.resumeBGM()
                        }
                        isBGMPlaying.toggle()
                    }) {
                        HStack {
                            Image(systemName: isBGMPlaying ? "pause.fill" : "play.fill") // 内部 SF Symbol 图标
                                .font(.title) // 设置图标大小
                            Text(isBGMPlaying ? "Pause BGM" : "Play BGM")
                                .font(.custom("Chalkboard SE", size: 20))
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 180, height: 65)
                        .background(Color.brown.opacity(0.8))
                        .cornerRadius(15)
                    }

                    
                    
                    Button(action: {
                        AudioManager.shared.playNextBGM()  // 切换下一首 BGM
                    }) {
                        Image(systemName: "forward.fill")
                            .font(.custom("Chalkboard SE", size: 18))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 55, height: 55)
                            .background(Color.brown.opacity(0.8))
                            .cornerRadius(12)
                    }
                }

                

// Meditation Part
                VStack(alignment: .leading, spacing: 8) {
                    Text("🧘 Meditation Audio Volume")
                        .font(.custom("Chalkboard SE", size: 20))
                        .foregroundColor(.brown)

                    HStack {
                        Image(systemName: "speaker.fill")
                            .foregroundColor(.brown)

                        Slider(value: $meditationVolume, in: 0...1, step: 0.1)
                            .accentColor(.brown)
                            .onChange(of: meditationVolume) { 
                                MeditationAudioManager.shared.setMeditationVolume(meditationVolume)
                            }

                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundColor(.brown)
                    }
                    .onChange(of: meditationVolume) {
                        MeditationAudioManager.shared.setMeditationVolume(meditationVolume)
                        MeditationAudioManager.shared.playShortMeditationFeedback()
                    }
                }
                .padding()

                Spacer()

  
                Button("🐶 Back") {
                    mvm.endSettings()
                }
                        .font(.custom("Chalkboard SE", size: 22))
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200)
                        .background(Color.brown)
                        .cornerRadius(12)
                        .padding(.bottom, 30)
                
                
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SettingsView(mvm: MainViewModel())
}


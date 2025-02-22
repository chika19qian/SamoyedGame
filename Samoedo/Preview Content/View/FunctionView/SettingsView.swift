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
    @State private var isBGMPlaying: Bool = true

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
                            .onChange(of: bgmVolume) { newValue in
                                AudioManager.shared.setBGMVolume(newValue)
                            }


                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundColor(.brown)
                    }
                }
                .padding()

                Button(action: {
                    if isBGMPlaying {
                        AudioManager.shared.pauseBGM()
                    } else {
                        AudioManager.shared.resumeBGM()
                    }
                    isBGMPlaying.toggle()
                }) {
                    Text(isBGMPlaying ? "⏸️ Pause BGM" : "▶️ Play BGM")
                        .font(.custom("Chalkboard SE", size: 20))
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200)
                        .background(Color.brown.opacity(0.8))
                        .cornerRadius(15)
                }
                .padding(.bottom, 10)


                VStack(alignment: .leading, spacing: 8) {
                    Text("🧘 Meditation Audio Volume")
                        .font(.custom("Chalkboard SE", size: 20))
                        .foregroundColor(.brown)

                    HStack {
                        Image(systemName: "speaker.fill")
                            .foregroundColor(.brown)

                        Slider(value: $meditationVolume, in: 0...1, step: 0.1)
                            .accentColor(.brown)
                            .onChange(of: meditationVolume) { newValue in
                                MeditationAudioManager.shared.setMeditationVolume(newValue)
                            }

                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundColor(.brown)
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


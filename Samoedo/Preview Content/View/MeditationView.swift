//
//  MeditationView.swift
//  Samoedo
//
//  Created by chika on 2025/2/22.
//

import SwiftUI

struct MeditationView: View {
    @StateObject private var viewModel = MeditationViewModel()
    @ObservedObject var mainViewModel: MainViewModel

    var body: some View {
        ZStack {
            Color.brown.opacity(0.67).edgesIgnoringSafeArea(.all)

            VStack {
                //Settings
                HStack {
                    Spacer()
                    Button(action: mainViewModel.openSettings) {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width:30, height: 30)
                            .foregroundColor(.brown)
                    }
                    Spacer().frame(width: 20)
                }.padding()
                
                Spacer()
                Text("🐶 Take a deep breath...")
                    .font(.custom("Chalkboard SE", size: 28))
                    .foregroundColor(.white)
                    .padding()
                
                ProgressView(value: viewModel.progress)
                    .progressViewStyle(HorizontalBrownProgressViewStyle())
                    .frame(width: 300, height: 12)
                    .padding()


                HStack(spacing: 40) {
                    Button(action: viewModel.backward5s) {
                        Image(systemName: "gobackward.5")
                            .font(.system(size: 30))
                            .foregroundColor(.brown)
                    }
                    
                    Button(action: viewModel.togglePlayPause) {
                        Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.brown)
                    }

                    Button(action: viewModel.forward5s) {
                        Image(systemName: "goforward.5") 
                            .font(.system(size: 30))
                            .foregroundColor(.brown)
                    }
                }
                .padding()
                
                if viewModel.isMeditationFinished {
                    Text("Great job! You look more relaxed now. 🧘‍♂️")
                        .font(.custom("Chalkboard SE", size: 25))
                        .foregroundColor(.white)
                        .padding()
                }
                

                Button("Finish") {
                    viewModel.stopMeditation()
                    mainViewModel.endMeditation()
                }
                .padding()
                .chalkboardFont(size: 25)
                .foregroundColor(Color.brown)
                .padding()
                .frame(width: 150, height: 50)
                .background(Color.white.opacity(0.9))
                .cornerRadius(15)
                
                Spacer()
            }
            
        }
        .onAppear {
                viewModel.setupAudio()
            }
        .onDisappear {
            viewModel.stopMeditation()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MeditationView(mainViewModel: MainViewModel())
}

        

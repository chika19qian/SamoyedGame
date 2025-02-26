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
            Color(red: 0.82, green: 0.74, blue: 0.62).edgesIgnoringSafeArea(.all)

            VStack {
                //Settings
                HStack {
                    Spacer()
                    Button(action:{
                        mainViewModel.openSettings()
                        mainViewModel.fromMeditation = true
                    }) {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width:30, height: 30)
                            .foregroundColor(.brown)
                    }
                    Spacer().frame(width: 20)
                }.padding()
                
                Spacer()
                
                Text("🐶 \(viewModel.selectedMeditationTitle)")
                    .font(.custom("Chalkboard SE", size: 28))
                    .foregroundColor(.white)
                    .padding()
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        ProgressView(value: viewModel.progress)
                            .progressViewStyle(HorizontalBrownProgressViewStyle())
                            .frame(width: 285, height: 12)
                            .padding()
                    }
                    .contentShape(Rectangle()) // 让整个区域都可交互
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                let locationX = gesture.location.x
                                let newProgress = min(max(locationX / geometry.size.width, 0), 1)
                                viewModel.seekToTime(newProgress * viewModel.duration)
                            }
                    )
                }
                .frame(width: 320, height: 12)
                .padding()


                HStack(spacing: 50) {
                    
                    Button(action: viewModel.playPreviousMeditation) {
                        Image(systemName: "backward.end.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.brown)
                    }
                    
                    
                    Button(action: viewModel.togglePlayPause) {
                        Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.brown)
                    }

                    
                    Button(action: viewModel.playNextMeditation) {
                        Image(systemName: "forward.end.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.brown)
                    }
                }
                .padding()
                
                
                

                Button("Finish") {
                    viewModel.stopMeditation()
                    mainViewModel.endMeditation()
                }
                .padding()
                .chalkboardFont(size: 25)
                .foregroundColor(Color.brown)
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


        

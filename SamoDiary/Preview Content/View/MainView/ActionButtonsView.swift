//
//  ActionButtonsView.swift
//  SamoDiary
//
//  Created by chika on 2025/2/27.
//

import SwiftUI

struct ActionButtonsView: View {
    @ObservedObject var vm: MainViewModel
    
    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            HStack {
                highlightableButton(
                    imageName: "pet-bowl",
                    action: {
                        vm.feed()
                        if vm.highlightFeedButton { vm.nextTutorialStep() }
                    },
                    isHighlighted: vm.highlightFeedButton,
                    disabled: vm.pet.foodCount == 0
                )
                
                Spacer().frame(width: 20)
                
                NavigationLink(destination: JournalReviewView()) {
                    ZStack {
                        Circle()
                            .fill(Color.brown)
                            .frame(width: 60, height: 60)
                            .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        
                        Image("diary")
                            .resizable()
                            .frame(width: 43, height: 40)
                    }
                }
            }
            
            HStack {
                NavigationLink(destination: MoodStepFlowView(mainViewModel: vm)) {
                       ZStack {
                           if vm.highlightMoodJournal {
                               Circle()
                                   .fill(Color.white.opacity(0.9))
                                   .frame(width: 80, height: 80)
                                   .overlay(
                                       Circle()
                                           .stroke(Color.yellow, lineWidth: 5)
                                           .blur(radius: 10)
                                   )
                           }
                           
                           Circle()
                               .fill(Color.brown)
                               .frame(width: 60, height: 60)
                               .overlay(Circle().stroke(Color.white, lineWidth: 3))
                           
                           Image("happy")
                               .resizable()
                               .frame(width: 40, height: 40)
                       }
                   }
                
                Spacer().frame(width: 20)
                
                NavigationLink(destination: Outdoor()) {
                    ZStack {
                        Circle()
                            .fill(Color.brown)
                            .frame(width: 60, height: 60)
                            .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        
                        Image("nature")
                            .resizable()
                            .frame(width: 45, height: 45)
                    }
                }
            }
        }
    }
    
    private func highlightableButton(imageName: String, action: @escaping () -> Void, isHighlighted: Bool, disabled: Bool = false, frameSize: CGSize = CGSize(width: 50, height: 50)) -> some View {
        ZStack {
            if isHighlighted {
                Circle()
                    .fill(Color.white.opacity(0.9))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Circle()
                            .stroke(Color.yellow, lineWidth: 5)
                            .blur(radius: 10)
                    )
            }

            Button(action: action) {
                ZStack {
                    Circle()
                        .fill(Color.brown)
                        .frame(width: 60, height: 60)
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    
                    Image(imageName)
                        .resizable()
                        .frame(width: frameSize.width, height: frameSize.height) // ✅ 使用 frameSize 变量
                        .clipShape(Circle())
                }
            }
            .disabled(disabled)
        }
    }

}


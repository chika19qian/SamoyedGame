//
//  OpeningView.swift
//  Samoedo
//
//  Created by chika on 2025/2/8.
//

import SwiftUI
import SpriteKit

struct OpeningSceneView: View {
    @ObservedObject var vm: MainViewModel  

    var body: some View {
        
        if vm.navigateToMain {
            TransitionController(transition: SKTransition.fade(withDuration: 1.0)){
                AnyView(MainView())
            }
        } else {
            VStack {
                if vm.isNamingDog {
                    nameDogView()
                        .keyboardAware()
                } else {
                    storyDialogueView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.5))
            .edgesIgnoringSafeArea(.all)
            .transition(.opacity)
        }
        
    }

    @ViewBuilder
    private func nameDogView() -> some View {
        ZStack {
            Image("puppy_door")
            VStack {
                Text("What will you name your puppy?")
                    .chalkboardFont(size: 24)
                    .foregroundColor(.white)
                    .padding()

                TextField("Enter a name", text: $vm.dogName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                Button("Confirm") {
                    vm.confirmDogName(newName: vm.dogName)
                }
                .chalkboardFont(size: 22)
                .foregroundColor(.white)
                .padding()
                .background(Color.brown.opacity(0.8))
                .cornerRadius(10)
            }
            .frame(width: 350, height: 200)
            .background(Color.brown.opacity(0.9))
            .cornerRadius(12)
            .transition(.opacity)
        }
        
    }

    @ViewBuilder
    private func storyDialogueView() -> some View {
        let dialogueLine = Dialogues.story[vm.openingDialogueIndex]
        let speaker = dialogueLine.speaker.replacingOccurrences(of: "{dogName}", with: vm.dogName)
        let message = dialogueLine.message.replacingOccurrences(of: "{dogName}", with: vm.dogName)

        VStack {
            Text(speaker)
                .bold()
                .chalkboardFont(size: 28)
                .foregroundColor(speaker == "Narration" ? .white : .yellow)
                .cornerRadius(12)
                .padding(.bottom, 2)

            Text(message)
                .chalkboardFont(size: 24)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 340, height: 180)
                .background(Color.brown.opacity(0.9))
                .cornerRadius(12)
                .padding()
        }
        .onTapGesture {
            vm.nextOpeningDialogue()
            print("🔍 After tap: isOpeningSceneFinished = \(vm.isOpeningSceneFinished)")
            if vm.isOpeningSceneFinished {
                print("🎬 Opening scene finished. Navigating to MainView...")
                vm.navigateToMain = true
            }
        }
        .background(Image("puppy_door"))
    }
}


#Preview {

    let vm = MainViewModel()

    return OpeningSceneView(vm: vm)
}

//
//  OpeningView.swift
//  SamoDiary
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
            ZStack {
                Image("door_box")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    if vm.isNamingDog {
                        nameDogView()
                            .keyboardAware()
                    } else {
                        storyDialogueView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .transition(.opacity)
            }
            
        }
        
    }

    @ViewBuilder
    private func nameDogView() -> some View {

        VStack {
            Text("Please name your puppy")
                .chalkboardFont(size: 24)
                .foregroundColor(.white)
                .padding()

            TextField("Enter a name", text: $vm.dogName)
                .textFieldStyle(PlainTextFieldStyle())
                .chalkboardFont(size: 24)
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                .frame(width: 200)
                .padding()
                .background(Color.white)
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

    @ViewBuilder
    private func storyDialogueView() -> some View {
        let dialogueLine = Dialogues.story[vm.openingDialogueIndex]
        
        let (speaker, message) = dialogueLine.localized(dogName: vm.dogName)

        VStack {
            Spacer().frame(height: 250)
            Text(speaker)
                .bold()
                .font(.custom("Chalkboard SE", size: 28))
                .foregroundColor(speaker == "Narration" ? .gray: .yellow)
                .cornerRadius(12)
                .padding(.bottom, 2)

            Text(message)
                .font(.custom("Chalkboard SE", size: 24))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 350, height: 180)
                .background(Color.brown.opacity(0.9))
                .cornerRadius(12)
                .padding()
            Spacer().frame(height: 0.1)
            Image(vm.openingDialogueIndex >= 3 ? "puppy_box" : "only_box")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 400)
            Spacer().frame(height: 10)

        }
        .onTapGesture {
            vm.nextOpeningDialogue()
            print("🔍 After tap: isOpeningSceneFinished = \(vm.isOpeningSceneFinished)")
            if vm.isOpeningSceneFinished {
                print("🎬 Opening scene finished. Navigating to MainView...")
                vm.navigateToMain = true
            }
        }
        
    }
}



#Preview {

    let vm = MainViewModel()

    return OpeningSceneView(vm: vm)
}

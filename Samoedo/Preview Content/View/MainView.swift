//
//  MainView.swift
//  Samoedo
//
//  Created by chika on 2025/2/6.
//

import SwiftUI

struct MainView: View {
    @StateObject private var vm = MainViewModel()
    private let timer = Timer.publish(every: 15, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image("room_background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer().frame(height: 30)
                    VStack(alignment: .leading) {
                        TextField("Name your pet!", text: $vm.pet.name)
                            .chalkboardFont(size: 28)
                            .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))

                        Text("\(vm.pet.happinessLevel)").bold() +
                        Text(" and ") +
                        Text("\(vm.pet.hunger)").bold()
                        Text("**Food** : **\(vm.pet.foodCount)**")

                    }.chalkboardFont(size: 20)
                        .foregroundColor(.brown)
                        .padding(.horizontal, 30)
                    
                    Spacer()
                    // samoyed image
                    Image(vm.pet.stageImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .onTapGesture {
                            vm.didTapSamoyed()
                        }
                }
                
                ZStack {
                    ProgressView(value: vm.pet.stageProgress)
                        .progressViewStyle(VerticalBrownProgressViewStyle())
                        .frame(width: 30, height: 200)
                        
                        .onTapGesture {
                            vm.showAgeInfo = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                vm.showAgeInfo = false
                                }
                        }
                    
                    if vm.showAgeInfo {
                        VStack {
                            Text("**\(vm.pet.stage )** ")
                            Text(" **\(vm.pet.age)** /**\(vm.pet.currentStageEnd)**")
                        }.chalkboardFont(size: 20)
                            .foregroundColor(.brown)
                            .padding(.horizontal, 0)
                            .transition(.opacity)
                            .animation(.easeInOut, value: vm.showAgeInfo)
                    }
                }.offset(x: 120, y: -250)
                
                HStack {
                    //Feed
                    ZStack {
                        Circle()
                            .fill(Color.brown)
                            .frame(width: 60, height: 60)
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: 3)
                            )
                        
                        Button(action: vm.feed) {
                            Image("pet-bowl")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                
                        }
                        .disabled(vm.pet.foodCount == 0)
                    }
                    
                    Spacer().frame(width: 20)
                    
                    // Journal Review
                    ZStack {
                        Circle()
                            .fill(Color.brown)
                            .frame(width: 60, height: 60)
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: 3)
                            )
                        
                        NavigationLink(destination: JournalReviewView()){
                            Image("diary")
                                .resizable()
                                .frame(width: 43, height: 40)
                        }
                    }
                }.offset(x: -110, y: -200)
                
                
                
                    ZStack {
                        // button
                        if vm.journalChoicePhase && vm.showJournalPrompt {
                            HStack {
                                NavigationLink(destination: StepFlowView(mainViewModel: vm)){
                                    Text("Yes, now")                           .chalkboardFont(size: 25)
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .frame(width: 150, height: 50)
                                        .background(Color.brown.opacity(0.9))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.white, lineWidth: 5)
                                        )
                                        .cornerRadius(15)
                                }
                                
                                
                                Button("No, later") {
                                    vm.showJournalPrompt = false
                                    vm.journalChoicePhase = false
                                    vm.objectWillChange.send()
                                }
                                .chalkboardFont(size: 25)
                                .foregroundColor(Color.white)
                                .padding()
                                .frame(width: 150, height: 50)
                                .background(Color.brown.opacity(0.9))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.white, lineWidth: 5)
                                )
                                .cornerRadius(15)
                            }
                            
                        } else {
                            // Message box
                            Text(vm.currentMessage)
                                .chalkboardFont(size: 28)                     .foregroundColor(.white)
                                .frame(height: 150)
                                .frame(maxWidth: .infinity)
                                .background(Color.brown.opacity(0.55))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 0)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                                .multilineTextAlignment(.center)
                                .offset( y: 230)
                                .onTapGesture {
                                    vm.didTapChatbot()
                                }
                        }

                    }
                    .padding()
                    .onReceive(timer) {_ in
                        vm.saveData()
                    }
            }.onAppear {
                vm.checkJournalStatus()
            }
        }
    }
}

#Preview {
    MainView()
}

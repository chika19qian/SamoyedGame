//
//  MainView.swift
//  SamoDiary
//
//  Created by chika on 2025/2/6.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var vm = MainViewModel()
    
    private let timer = Timer.publish(every: 15, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image("room_background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
// Leftup Information
                VStack {
                    Spacer().frame(height: 30)
                    VStack(alignment: .leading) {
                        Text("\(vm.pet.name)")
                            .chalkboardFont(size: 28)
                            .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                        
                        Text("\(vm.pet.happinessLevel)").bold() +
                        Text(" and ") +
                        Text("\(vm.pet.hunger)").bold()
                        Text("**Food** : **\(vm.pet.foodCount)**")
                        
                    }.chalkboardFont(size: 20)
                        .foregroundColor(.brown)
                        .padding(.horizontal, 40)
                        .offset(x: -75, y: -5)
                    
                    Spacer()
// samoyed image
                    if vm.pet.happinessLevel == String(localized: "Unhappy") {
                        Image(vm.pet.stageImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 450, height: 450)
                            .onTapGesture {
                                vm.didTapSamoyed()
                            }
                            .onLongPressGesture {
                                vm.startMeditation()
                            }
                    } else {
                        AnimatedImageView(folderName: vm.pet.stageImage)
                            .onTapGesture {
                                vm.didTapSamoyed()
                            }
                            .onLongPressGesture {
                                vm.startMeditation()
                            }
                        
                    }

                }

// Right up Status
                ZStack {
                    
                    VStack {
                        //Settings
                        Button(action:{
                            vm.openSettings()
                            vm.fromMeditation = false
                        }) {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width:30, height: 30)
                                .foregroundColor(.brown)
                        }
                        Spacer().frame(height: 10)
                        
                        // Progress
                        ProgressView(value: vm.pet.stageProgress)
                            .progressViewStyle(VerticalBrownProgressViewStyle())
                            .frame(width: 30, height: 200)
                        
                            .onTapGesture {
                                vm.showAgeInfo = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    vm.showAgeInfo = false
                                }
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
                
                
// 4 Buttons
                VStack {
                    Spacer().frame(height: 50)
                    HStack {
                        //Feed
                        Button(action: vm.feed) {
                            ZStack {
                                Circle()
                                    .fill(Color.brown)
                                    .frame(width: 60, height: 60)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                
                                Image("pet-bowl")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }
                        }
                        .disabled(vm.pet.foodCount == 0)
                        
                        
                        Spacer().frame(width: 20)
                        
                        // Journal Review
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
                    // Mood Journal
                    HStack {
                        NavigationLink(destination: MoodStepFlowView(mainViewModel: vm)) {
                            ZStack {
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
                }.offset(x: -110, y: -200)
               
                
                
// Daily Journal Prompt
                if vm.showJournalPrompt {
                    VStack {
                        Text(Dialogues.journalPrompt)
                            .chalkboardFont(size: 28)                     .foregroundColor(.white)
                            .frame(width:350, height: 150)
                            .background(Color.brown.opacity(0.98))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 7)
                            )
                            .multilineTextAlignment(.center)
                            .cornerRadius(12)
                            .padding()
                            .onTapGesture {
                                vm.showJournalButtons()
                            }
                    }
                }
                    
                if vm.journalChoicePhase {
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
                            vm.skipJournal()
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
                    }.transition(.opacity)
                        .animation(.easeInOut, value: vm.journalChoicePhase)
                    
                }
                    

    // Daily Talk
                    if vm.showingDialog {
                        Text(String(localized: String.LocalizationValue(vm.dialogMessage)))
                            .chalkboardFont(size: 28)                     .foregroundColor(.white)
                            .padding(12)
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
                            .padding()
                    }
                    
                    
                                    
                        }.onReceive(timer) {_ in
                        vm.saveData()
                }.onAppear {
                    vm.checkJournalStatus()
                }
                .navigationDestination(isPresented: $vm.navigateToSettings) {
                    if !vm.isMeditationActive {  
                        SettingsView(mvm: vm)
                    }
                }

                .navigationDestination(isPresented: $vm.isMeditationActive){
                    MeditationView( mainViewModel: vm)
                }
        }

        
            }
}

#Preview {
    MainView()
}

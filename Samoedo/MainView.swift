//
//  MainView.swift
//  Samoedo
//
//  Created by chika on 2025/2/6.
//

import SwiftUI

struct MainView: View {
    @StateObject private var vm = ViewModel()
    private let timer = Timer.publish(every: 15, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            // 背景房间
            Image("room_background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                
                VStack(alignment: .leading) {
                    TextField("Name your pet!", text: $vm.pet.name)
                        .font(.custom("Chalkboard SE", size: 28)) // 设置字体
                        .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1)) // 让文字变成白色
                    
                    Text("Age: **\(vm.pet.age)** seconds")
                    Text("Status: ") +
                    Text("\(vm.pet.happinessLevel)").bold() +
                    Text(" and ") +
                    Text("\(vm.pet.hunger)").bold()
                    
                }.font(.custom("Chalkboard SE", size: 20))
                    .foregroundColor(.brown)
                    .padding(.horizontal, 30)
                
                
                HStack {
                    Image("journal")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .onTapGesture {
                            vm.didTapJournalBook()
                        }
                    Spacer().frame(width: 70)
                    Button(action: vm.feed) {
                        Text("Feed")
                            .font(.custom("Chalkboard SE", size: 25))
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
                    .font(.custom("Chalkboard SE", size: 20))
                    
                }
                Spacer().frame(height: 90)
                
                ZStack {
                    Image(vm.pet.happinessLevel == "Happy" ? "happy_samoyed" : "sad_samoyed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .onTapGesture {
                            vm.didTapSamoyed()
                        }
                    
                    
                    if vm.journalChoicePhase {
                        HStack {
                            Button("Yes, now") {
                                vm.didTapJournalBook()
                            }
                            .font(.custom("Chalkboard SE", size: 25))
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(width: 150, height: 50)
                            .background(Color.brown.opacity(0.9))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white, lineWidth: 5)
                            )
                            .cornerRadius(15)
                            
                            Button("No, later") {
                                vm.showJournalPrompt = false
                                vm.journalChoicePhase = false
                                vm.objectWillChange.send()
                            }
                            .font(.custom("Chalkboard SE", size: 25))
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
                        Text(vm.currentMessage)
                            .font(.system(size: 23, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .frame(height: 140)
                            .frame(maxWidth: .infinity)
                            .background(Color.brown.opacity(0.5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                            .multilineTextAlignment(.center)
                            .offset(y: 65)
                            .onTapGesture {
                                vm.didTapChatbot()
                            }
                    }

                }
                .padding()
                .onReceive(timer) {_ in
                    vm.saveData()
                }
            }
        }
    }
}

#Preview {
    MainView()
}

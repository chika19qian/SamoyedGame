//
//  PetInteractionView.swift
//  SamoDiary
//
//  Created by chika on 2025/2/27.
//


import SwiftUI

struct PetInteractionView: View {
    @ObservedObject var vm: MainViewModel

    var body: some View {
// Leftup Information
        VStack {
            Spacer().frame(height: 30)
            VStack {
                VStack(alignment: .leading) {
                    Text("\(vm.pet.name)")
                        .chalkboardFont(size: 28)
                        .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                    
                    HStack {
                        Text("\(vm.pet.happinessLevel)").bold()
                        Text(" and ")
                        Text("\(vm.pet.hunger)").bold()
                    }
                    
                    Text("**Food** : **\(vm.pet.foodCount)**")
                }
                .chalkboardFont(size: 20)
                .foregroundColor(.brown)
                .padding(.horizontal, 40)
                .frame(maxWidth: 300, alignment: .leading) // ✅ 限制最大宽度，防止超出
                .offset(x: -70, y: -5) // ✅ 适当调整偏移量
            }

            
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
                
                
    }
}


#Preview {
    PetInteractionView(vm: MainViewModel())
}

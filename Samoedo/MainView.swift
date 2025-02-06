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
                    .padding()
                
                Spacer().frame(height: 60)
                    
                    // 萨摩耶形象
                Image(vm.pet.happinessLevel == "Happy" ? "happy_samoyed" : "sad_samoyed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 380, height: 400)
                        .onTapGesture {
                            vm.didTapSamoyed()
                        }
                    
                Spacer()
                
                Button(action: vm.feed) {
                    Text("Feed")
                        .font(.custom("Chalkboard SE", size: 25))
                        .foregroundColor(Color.white) // 深棕色字体
                        .padding()
                        .frame(width: 150, height: 50)
                        .background(Color.brown.opacity(0.9)) // 浅棕色背景
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white, lineWidth: 5) // 白色外框
                        )
                        .cornerRadius(15) // 圆润的外观
                }
                .font(.custom("Chalkboard SE", size: 20))
            }
            .padding()
            .onReceive(timer) {_ in
                vm.saveData()
                }
        }
    }
}

#Preview {
    MainView()
}

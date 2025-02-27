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
                
                PetInteractionView(vm: vm)
                ActionButtonsView(vm: vm).offset(x:-100,y:-200)
                TutorialOverlayView(vm: vm)
                
                // Daily Journal Prompt
                JournalPromptView(vm:vm)
                    
                // Daily Talk
                DailyDialogueView(vm: vm)
                                    
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

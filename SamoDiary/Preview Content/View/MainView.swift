//
//  MainView.swift
//  SamoDiary
//
//  Created by chika on 2025/2/6.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var vm = MainViewModel()
    @ObservedObject var settingsRepo = SettingsRepository.shared
    
    private let timer = Timer.publish(every: 15, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack{
            GeometryReader {
                geometry in
                ZStack{
                    Image("room_background")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    
                    
                    PetInteractionView(vm: vm)
                    ActionButtonsView(vm: vm).position(x: geometry.size.width * 0.25, y: geometry.size.height * 0.23)
                    TutorialOverlayView(vm: vm).position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    
                    // Daily Journal Prompt
                    JournalPromptView(vm:vm).position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        
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
}

#Preview {
    MainView()
}

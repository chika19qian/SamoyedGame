//
//  JournalPromptView.swift
//  SamoDiary
//
//  Created by chika on 2025/2/27.
//

import SwiftUI

struct JournalPromptView: View {
    @ObservedObject var vm: MainViewModel
    
    var body: some View {
        if vm.showJournalPrompt && !vm.journalChoicePhase {
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
    }
}

#Preview {
    JournalPromptView(vm: MainViewModel())
}

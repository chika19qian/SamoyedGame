//
//  DailyDialogueView.swift
//  SamoDiary
//
//  Created by chika on 2025/2/27.
//

import SwiftUI

struct DailyDialogueView: View {
    @ObservedObject var vm: MainViewModel
    
    var body: some View {
        if vm.showingDialog && !vm.isTutorialActive {
            Text(String(localized: String.LocalizationValue(vm.dialogMessage)))
                .chalkboardFont(size: 28)                     .foregroundColor(.white)
                .padding(12)
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .background(Color.brown.opacity(0.55))
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white, lineWidth: 2)
                )
                .multilineTextAlignment(.center)
                .offset( y: 230)
                .onTapGesture {
                    vm.didTapChatbot()
                }
                .padding()
        }
    }
}

#Preview {
    DailyDialogueView(vm: MainViewModel())
}

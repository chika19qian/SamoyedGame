//
//  TutorialOverlayView.swift
//  SamoDiary
//
//  Created by chika on 2025/2/27.
//


import SwiftUI

struct TutorialOverlayView: View {
    @ObservedObject var vm: MainViewModel

    var body: some View {
        VStack {
            Spacer()
            if vm.isTutorialActive {
                Text(TextFormatter.parse(Dialogues.tutorial[vm.tutorialStep].messageKey))
                    .chalkboardFont(size: 24)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width:350, height: 200)
                    .background(Color.brown.opacity(0.9))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white, lineWidth: 7)
                    )
                    .cornerRadius(15)
                    .multilineTextAlignment(.center)
                    .onTapGesture {
                        vm.nextTutorialStep()
                    }
            }
            Spacer()
        }
    }
}


#Preview {
    TutorialOverlayView(vm: MainViewModel())
}

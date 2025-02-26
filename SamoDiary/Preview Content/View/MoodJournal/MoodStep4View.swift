//
//  MoodStep4View.swift
//  SamoDiary
//
//  Created by chika on 2025/2/25.
//

import SwiftUI

struct MoodStep4View: View {
    @ObservedObject var viewModel: MoodJournalViewModel
    @ObservedObject var mainViewModel: MainViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Spacer()

            Text(String(localized: "Why do you feel this way?"))
                .chalkboardFont(size: 28)
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                .frame(alignment:.center)
                .padding()

            TextEditor(text: $viewModel.userInputReason)
                .font(.custom("Chalkboard SE", size: 18))
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                .frame(height: 350)
                .border(Color.gray, width: 2)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.brown, lineWidth: 4)
                )
                .padding()

            Spacer()

            Button(action: {
                viewModel.saveJournal(vm: mainViewModel)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    presentationMode.wrappedValue.dismiss()  
                }
            }) {
                Text(String(localized: "Save"))
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
            .padding()

            Spacer()
        }
        .padding()
    }
}
#Preview {
    MoodStep4View(viewModel: MoodJournalViewModel(),mainViewModel: MainViewModel())
}

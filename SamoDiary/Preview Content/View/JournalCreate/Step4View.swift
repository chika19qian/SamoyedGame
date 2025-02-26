//
//  Step4View.swift
//  SamoDiary
//
//  Created by chika on 2025/2/7.
//

import SwiftUI

struct Step4View: View {
    @ObservedObject var viewModel: JournalViewModel
    

    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.generateStep4Question())
                .chalkboardFont(size: 28)
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                .frame(alignment:.center)
                .padding()
            
            Spacer()

            TextEditor(text: $viewModel.currentEntry.step4Response)
                .font(.custom("Chalkboard SE", size: 18))
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                .frame(height: 370)
                .border(Color.gray, width: 2)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.brown, lineWidth: 4)
                )
                .padding()
            Button(action: { viewModel.nextStep() }) {
                Text("Next")
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
        }
        .padding()
    }
}

#Preview {
    Step4View(viewModel: JournalViewModel())
}

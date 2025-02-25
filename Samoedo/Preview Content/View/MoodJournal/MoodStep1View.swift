//
//  MoodStep1View.swift
//  Samoedo
//
//  Created by chika on 2025/2/25.
//

import SwiftUI

struct MoodStep1View: View {
    @ObservedObject var viewModel: MoodJournalViewModel

    let moodImages: [MoodCategory: String] = [
        .veryBad: "😢",
        .bad: "🙁",
        .neutral: "😐",
        .good: "🙂",
        .veryGood: "😄"
    ]

    var body: some View {
        VStack {
            Spacer()

            Text(String(localized: "How do you feel now?"))
                .chalkboardFont(size: 28)
                .foregroundColor(Color.brown)

            HStack(spacing: 1) {
                ForEach(MoodCategory.allCases, id: \.self) { mood in
                    VStack {
                        Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) { 
                                        viewModel.selectMood(mood)
                                    }
                        }) {
                            Text(moodImages[mood] ?? "❓")
                                .font(.system(size: 40))
                                .padding()
                                .background(viewModel.selectedMood == mood ? Color.brown.opacity(0.3) : Color.clear)
                                .clipShape(Circle())
                        }

                        Button(action: {
                            viewModel.selectMood(mood)
                        }) {
                            Text(mood.localizedName)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color.brown)
                                .padding(.vertical, 5)
                                .frame(width: 70, height: 55)
                                .background(viewModel.selectedMood == mood ? Color.brown.opacity(0.3) : Color.brown.opacity(0.0))
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding()
            

            Spacer()


        }
        
    }
}


#Preview {
    MoodStep1View(viewModel: MoodJournalViewModel())
}

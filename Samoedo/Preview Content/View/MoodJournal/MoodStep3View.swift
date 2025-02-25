//
//  MoodStep3View.swift
//  Samoedo
//
//  Created by chika on 2025/2/25.
//


import SwiftUI

struct MoodStep3View: View {
    @ObservedObject var viewModel: MoodJournalViewModel

    var body: some View {
        ScrollView {
            Text(String(localized: "How would you describe your mood?"))
                .chalkboardFont(size: 28)
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                ForEach(moodDetailsMap[viewModel.selectedMood ?? .neutral] ?? [], id: \.self) { moodDetail in
                    Button(action: {
                        if viewModel.selectedMoodDetails.contains(moodDetail) {
                            viewModel.selectedMoodDetails.removeAll { $0 == moodDetail }
                        } else {
                            viewModel.selectedMoodDetails.append(moodDetail)
                        }
                    }) {
                        VStack {
                            Text(moodDetail)
                                .foregroundColor(.brown)
                                .chalkboardFont(size: 20)
                        }
                        .frame(width: 120, height: 100)
                        .background(viewModel.selectedMoodDetails.contains(moodDetail) ? Color.brown.opacity(0.3) : Color.brown.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
            }
        }
        Button(action: { viewModel.nextStep() }) {
            Text("Next")
                .chalkboardFont(size: 25)
                .foregroundColor(Color.white)
                .padding()
                .frame(width: 150, height: 50)
                .background(Color.brown.opacity(0.8))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white, lineWidth: 5)
                )
                .cornerRadius(15)
        }
        .opacity(viewModel.selectedMoodDetails.isEmpty ? 0:1)
        .disabled(viewModel.selectedMoodDetails.isEmpty)
    }
}
#Preview {
    MoodStep3View(viewModel: MoodJournalViewModel())
}

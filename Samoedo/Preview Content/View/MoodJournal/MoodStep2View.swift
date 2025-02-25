//
//  MoodStep2View.swift
//  Samoedo
//
//  Created by chika on 2025/2/25.
//

import SwiftUI

struct MoodStep2View: View {
    @ObservedObject var viewModel: MoodJournalViewModel

    var body: some View {
        VStack {
            Spacer()
            Text(String(localized: "What influenced your mood today?"))
                .chalkboardFont(size: 28)
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
            Spacer()
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                ForEach(eventCategories) { event in
                    Button(action: {
                        if viewModel.selectedEvents.contains(where: { $0.id == event.id }) {
                            viewModel.selectedEvents.removeAll { $0.id == event.id }
                        } else if viewModel.selectedEvents.count < 3 {
                            viewModel.selectedEvents.append(event)
                        }
                    }) {
                        VStack {
                            Text(event.icon)
                                .font(.largeTitle)
                            Text(event.localizedName)
                                .foregroundColor(Color.brown)
                        }
                        .padding()
                        .chalkboardFont(size: 15)
                        .frame(width:115,height: 105)
                        .background(viewModel.selectedEvents.contains(where: { $0.id == event.id }) ? Color.brown.opacity(0.3) : Color.gray.opacity(0.1))
                        .cornerRadius(10)
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
            .opacity(viewModel.selectedEvents.isEmpty ? 0:1)
            .disabled(viewModel.selectedEvents.isEmpty)
        }
    }
}
#Preview {
    MoodStep2View(viewModel: MoodJournalViewModel())
}

//
//  Step2View.swift
//  Samoedo
//
//  Created by chika on 2025/2/7.
//

import SwiftUI

struct Step2View: View {
    @ObservedObject var viewModel: JournalViewModel

    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.morning ? "What will you focus on today?" : "What made you feel good today?")
                .chalkboardFont(size: 28)
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                .frame(alignment:.center)
                .padding()

            Spacer()
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                ForEach(eventCategories) { event in  
                    Button(action: {
                        if viewModel.currentEntry.step2Response.contains(where: { $0.id == event.id }) {
                            viewModel.currentEntry.step2Response.removeAll { $0.id == event.id }
                        } else if viewModel.currentEntry.step2Response.count < 3 {
                            viewModel.currentEntry.step2Response.append(event)
                        }
                    }) {
                        VStack {
                            Text(event.icon)
                                .font(.largeTitle)
                            Text(event.name)
                                .foregroundColor(Color.brown)
                        }
                        .padding()
                        .chalkboardFont(size: 15)
                        .frame(width:115,height: 105)
                        .background(viewModel.currentEntry.step2Response.contains(where: { $0.id == event.id }) ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
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
                    .background(Color.brown.opacity(0.9))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 5)
                    )
                    .cornerRadius(15)
            }
            .opacity(viewModel.currentEntry.step2Response.isEmpty ? 0:1)
            .disabled(viewModel.currentEntry.step2Response.isEmpty)
        }
        .padding()
    }
}
#Preview {
    Step2View(viewModel: JournalViewModel())
}

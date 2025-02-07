//
//  Step1View.swift
//  Samoedo
//
//  Created by chika on 2025/2/7.
//

import SwiftUI

struct Step1View: View {
    @ObservedObject var viewModel: JournalViewModel
    
    
    let morningMoods = ["moon", "moon.fill", "moon.zzz.fill", "moon.stars.fill", "moon.circle.fill"]
    let eveningMoods = [ "sun.dust", "sun.min", "sun.min.fill", "sun.max", "sun.max.fill"]

    var body: some View {
        VStack {
            
            
            Spacer().frame(height: 100)
            
            Text(viewModel.morning ? "How was your sleep last night?" : "How do you feel today?")
                .chalkboardFont(size: 28)
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                .frame(alignment:.center)
                .padding()
            
            Spacer().frame(height: 150)

            HStack(spacing: 20) {
                let moods = viewModel.morning ? morningMoods : eveningMoods
                ForEach(0..<5, id: \.self) { index in
                    Button(action: { viewModel.currentEntry.step1Response = "\(index + 1)" }) {
                        Image(systemName: moods[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(viewModel.currentEntry.step1Response == "\(index + 1)" ? .yellow : .brown)
                    }
                }
            }
            Spacer()
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
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    Step1View(viewModel: JournalViewModel())
}

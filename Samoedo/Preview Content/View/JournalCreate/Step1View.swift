//
//  Step1View.swift
//  Samoedo
//
//  Created by chika on 2025/2/7.
//

import SwiftUI

struct Step1View: View {
    @ObservedObject var viewModel: JournalViewModel
    
    
    let morningMoods = ["moonphase.new.moon.inverse","moonphase.waning.crescent.inverse", "moonphase.last.quarter.inverse",  "moonphase.waning.gibbous.inverse", "moonphase.full.moon.inverse"]
    let eveningMoods = [ "cloud.bolt.rain", "cloud.heavyrain",  "cloud","sun.min", "sun.max"]

    var body: some View {
        VStack {
            
            
            Spacer().frame(height: 100)
            
            Text(viewModel.morning ? "How was your sleep last night?" : "How do you feel today?")
                .chalkboardFont(size: 28)
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                .frame(alignment:.center)
                .padding()
            Text( " (From 1-not good to 5-very good)")
                .chalkboardFont(size: 18)
                .foregroundColor(Color(red: 0.4, green: 0.23, blue: 0.1))
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
                            .frame(width: CGFloat(45 + index * 3), height: CGFloat(45 + index * 3))
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
            .opacity(viewModel.currentEntry.step1Response.isEmpty ? 0:1)
            .disabled(viewModel.currentEntry.step1Response.isEmpty)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    Step1View(viewModel: JournalViewModel())
}

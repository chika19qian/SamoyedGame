//
//  Step5View.swift
//  Samoedo
//
//  Created by chika on 2025/2/7.
//

import SwiftUI

struct Step5View: View {
    @ObservedObject var viewModel: JournalViewModel
    @Environment(\.presentationMode) private var presentationMode


    var body: some View {
        VStack {
        
            Spacer()
            Text(viewModel.morning ? "If today is fulfilling and brings unexpected joy, how would you feel?" : "What beautiful things are you looking forward to tomorrow?")
                .chalkboardFont(size: 28)
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                .frame(alignment:.center)
                .padding()
            
            Spacer()
            
            TextEditor(text: $viewModel.currentEntry.step5Response)
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
            Button("Save") {
                print("Save被点击")
                viewModel.saveJournal()
                
                presentationMode.wrappedValue.dismiss()
            }.padding()
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
    }
}

#Preview {
    Step5View(viewModel: JournalViewModel())
}

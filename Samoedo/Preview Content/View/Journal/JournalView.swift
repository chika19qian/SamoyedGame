//
//  JournalView.swift
//  Samoedo
//
//  Created by chika on 2025/2/6.
//

import SwiftUI

struct JournalView: View {
    @ObservedObject var journalViewModel: JournalViewModel
    var mainViewModel: MainViewModel

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
            VStack {
                
                
                
                HStack {
                    Button(action: { journalViewModel.previousStep() }) {
                        Image(systemName: "arrow.backward")
                            .font(.title)
                    }
                    Spacer()
                    Text("\(journalViewModel.step)/5")
                }
                .foregroundColor(Color.brown)
                .padding()

                    

                //StepContentView(journalViewModel: JournalViewModel)
                
                Spacer()
                
                Button(action: { journalViewModel.nextStep() }) {
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
                
                TextEditor(text: $journalViewModel.content)
                    .font(.custom("Chalkboard SE", size: 18))
                    .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                    .frame(height: 400)
                    .border(Color.gray, width: 2)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.brown, lineWidth: 4)
                    )
                    .padding()
                
                Button("Save") {
                    print("Save被点击")
                    journalViewModel.saveJournal()
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
                Spacer()
            }
            .onAppear {
                journalViewModel.onSave = {
                    mainViewModel.checkJournalStatus()  // 
                }
            }

    }
}

#Preview {
    JournalView(journalViewModel: JournalViewModel(), mainViewModel: MainViewModel())
}

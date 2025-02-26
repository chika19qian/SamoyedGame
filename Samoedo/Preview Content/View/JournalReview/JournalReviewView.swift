//
//  JournalReviewView.swift
//  Samoedo
//
//  Created by chika on 2025/2/7.
//

import SwiftUI

struct JournalReviewView: View {
    @StateObject var viewModel = JournalReviewViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {

                Color(red: 0.82, green: 0.74, blue: 0.62).edgesIgnoringSafeArea(.all)

                List(viewModel.journalEntries) { entry in
                    NavigationLink(destination: JournalDetailView(viewModel: viewModel, entry: entry)) {
                        JournalRowView(viewModel: viewModel, entry: entry)
                    }.listRowBackground(Color(red: 0.97, green: 0.94, blue: 0.88))

                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(red: 0.65, green: 0.50, blue: 0.35))
                            .font(.system(size: 20, weight: .bold))
                    }
                }
                

                ToolbarItem(placement: .principal) {
                    
                    Text("Journal Review")
                        .chalkboardFont(size: 28)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .toolbarBackground(Color.brown, for: .navigationBar)
        }.navigationBarBackButtonHidden()
            .gesture(DragGesture().onEnded { value in
                if value.translation.width > 100 { 
                    presentationMode.wrappedValue.dismiss()
                }
            })
    }
}



struct JournalRowView: View {
    @ObservedObject var viewModel : JournalReviewViewModel
    let entry: JournalEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.formattedDate(entry.date))
                .font(.custom("Chalkboard SE", size: 16))
                .foregroundColor(.gray)

            Text(viewModel.previewText(for: entry))
                .font(.system(size: 18, weight: .medium, design: .rounded)) // SF Rounded
                .foregroundColor(Color(red: 0.45, green: 0.35, blue: 0.25))
                .lineLimit(2)
                .truncationMode(.tail)
        }
        
        .padding(.vertical, 8)
    }
}



#Preview {
    JournalReviewView()
}

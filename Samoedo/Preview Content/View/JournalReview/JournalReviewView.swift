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

                Color.brown.opacity(0.67).edgesIgnoringSafeArea(.all)

                List(viewModel.journalEntries) { entry in
                    NavigationLink(destination: JournalDetailView(viewModel: viewModel, entry: entry)) {
                        JournalRowView(viewModel: viewModel, entry: entry)
                    }
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
                            .foregroundColor(.brown)
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

            Text(entry.previewText)
                .font(.body)
                .font(.custom("Chalkboard SE", size: 16))
                .lineLimit(2)  
                .truncationMode(.tail)
        }
        .background(Color.white.opacity(0.8))
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
        .padding(.vertical, 8)
    }
}



#Preview {
    JournalReviewView()
}

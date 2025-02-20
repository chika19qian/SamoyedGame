//
//  JournalReviewView.swift
//  Samoedo
//
//  Created by chika on 2025/2/7.
//

import SwiftUI

struct JournalReviewView: View {
    @StateObject var viewModel = JournalReviewViewModel()

    var body: some View {
        
        NavigationView {
            
            List(viewModel.journalEntries) { entry in
                NavigationLink(destination: JournalDetailView(viewModel: JournalReviewViewModel(), entry: entry)) {
                    JournalRowView(viewModel:viewModel, entry: entry)
                }
            }
            .navigationTitle("📖 Journal Reveiw")
            .font(.custom("Chalkboard SE", size: 18))
        }
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
        .padding(.vertical, 8)
    }
}



#Preview {
    JournalReviewView()
}

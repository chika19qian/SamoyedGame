//
//  EditJournalView.swift
//  Samoedo
//
//  Created by chika on 2025/2/8.
//

import SwiftUI

struct EditJournalView: View {
    @ObservedObject var viewModel: JournalReviewViewModel
    @State private var editedContent: String
    var entry: JournalEntry
    @Environment(\.presentationMode) var presentationMode

    init(viewModel: JournalReviewViewModel, entry: JournalEntry) {
        self.viewModel = viewModel
        self.entry = entry
        _editedContent = State(initialValue: entry.journalContent)
    }

    var body: some View {
        VStack {
            Text("Edit Journal")
                .font(.title)
                .bold()

            TextEditor(text: $editedContent)
                .padding()
                .border(Color.gray)

            Button("Save") {
                viewModel.updateJournal(entry: entry, newContent: editedContent)
                presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.white)
            .padding()
            .frame(width: 150, height: 50)
            .background(Color.blue.opacity(0.9))
            .cornerRadius(15)
        }
        .padding()
    }
}

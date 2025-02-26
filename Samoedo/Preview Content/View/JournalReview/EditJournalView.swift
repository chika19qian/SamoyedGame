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
                .chalkboardFont(size: 30)
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                .bold()

            TextEditor(text: $editedContent)
                .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                .padding(10)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.brown, lineWidth: 2)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .brown.opacity(0.2), radius: 3, x: 0, y: 2)

            Button("Save") {
                viewModel.updateJournal(entry: entry, newContent: editedContent)
                presentationMode.wrappedValue.dismiss()
            }
            .chalkboardFont(size: 25)
            .foregroundColor(.white)
            .padding()
            .frame(width: 150, height: 50)
            .background(Color.brown.opacity(0.9))
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white, lineWidth: 5)
            )
        
        }.onTapGesture {
            hideKeyboard()
        }
        .padding()
    }
}

#Preview {
    EditJournalView(viewModel: JournalReviewViewModel(), entry: JournalEntry(
        id: UUID(),
        date: Date(),
        mode: .morning,
        step1Response: "Slept well 😴",
        step2Response: [Event(id: UUID(), name: "Study", icon: "📖")],
        step3Response: "Had a productive study session",
        step4Response: "Plan to review notes",
        step5Response: "Looking forward to tomorrow!",
        journalContent: "ok"
    ))
}

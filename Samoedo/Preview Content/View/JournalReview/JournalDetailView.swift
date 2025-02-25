//
//  JournalDetailView.swift
//  Samoedo
//
//  Created by chika on 2025/2/7.
//

import SwiftUI

struct JournalDetailView: View {
    @ObservedObject var viewModel: JournalReviewViewModel
    let entry: JournalEntry

    @State private var showEditView = false
    @State private var showDeleteAlert = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
                                
            VStack(alignment: .leading, spacing: 10) {
                Text(formattedDate(entry.date))
                    .frame(alignment: .center)
                    .font(.custom("Chalkboard SE", size: 18))
                    .foregroundColor(.brown)
                Spacer()

                Text(entry.journalContent)
                    .font(.custom("Chalkboard SE", size: 20))
                    .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                    .padding()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
        }
        .navigationBarBackButtonHidden()

        .toolbar {
            ToolbarItem(placement: .principal) {
                
                Text("📜 Journal Details")
                    .chalkboardFont(size: 28)
                    .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.brown)
                            .font(.system(size: 20, weight: .bold))
                    }
                }
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button("Edit", action: { showEditView = true })
                    Button("Delete", role: .destructive, action: { showDeleteAlert = true })
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundColor(.brown)
                }
            }
                }
                .alert("Are you sure you want to delete this journal?", isPresented: $showDeleteAlert) {
                    Button("Cancel", role: .cancel) {}
                    Button("Delete", role: .destructive) {
                        viewModel.deleteJournal(entry)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .sheet(isPresented: $showEditView) {
                    EditJournalView(viewModel: viewModel, entry: entry)
                }
            
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    JournalDetailView(viewModel: JournalReviewViewModel(), entry: JournalEntry(
        id: UUID(),
        date: Date(), mode: .morning,
        step1Response: "Slept well 😴",
        step2Response: [Event(id: UUID(), name: "Study", icon: "📖")],
        step3Response: "Had a productive study session",
        step4Response: "Plan to review notes",
        step5Response: "Looking forward to tomorrow!",
        journalContent: "oksssddg"
    ))
}



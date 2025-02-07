//
//  JournalDetailView.swift
//  Samoedo
//
//  Created by chika on 2025/2/7.
//

import SwiftUI

struct JournalDetailView: View {
    let entry: JournalEntry

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(formattedDate(entry.date))
                    .frame(alignment: .center)
                    .font(.custom("Chalkboard SE", size: 18))
                    .foregroundColor(.gray)
                Spacer()

                Text(entry.journalContent)
                    .font(.custom("Chalkboard SE", size: 18))
                    .padding()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationTitle("📜 Journal Details")
    }

    /// **📌 格式化日期（YYYY/MM/DD）**
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    JournalDetailView(entry: JournalEntry(
        id: UUID(),
        date: Date(),
        step1Response: "Slept well 😴",
        step2Response: [Event(id: UUID(), name: "Study", icon: "📖")],
        step3Response: "Had a productive study session",
        step4Response: "Plan to review notes",
        step5Response: "Looking forward to tomorrow!",
        journalContent: "ok"
    ))
}



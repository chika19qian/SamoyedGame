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
                    .font(.custom("Chalkboard SE", size: 16))
                    .foregroundColor(.gray)

                Text(entry.content)
                    .font(.custom("Chalkboard SE", size: 16)) 
                    .padding()
            }
            .padding()
        }
        .navigationTitle("📜 日记详情")
    }

    /// **📌 格式化日期（YYYY/MM/DD）**
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date)
    }
}

#Preview {
    JournalDetailView(entry: JournalEntry(date: Date(), content: "今天是个好日子，阳光明媚，心情很好！"))
}


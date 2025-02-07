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
                NavigationLink(destination: JournalDetailView(entry: entry)) {
                    JournalRowView(entry: entry)  // ✅ 复用组件，保持整洁
                }
            }
            .navigationTitle("📖 Journal Reveiw")
            .font(.custom("Chalkboard SE", size: 18))
        }
    }
}

/// **📌 复用组件 - 每个日记条目**
struct JournalRowView: View {
    let entry: JournalEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(formattedDate(entry.date))
                .font(.custom("Chalkboard SE", size: 16))
                .foregroundColor(.gray)

            Text(entry.step3Response)
                .font(.body)
                .font(.custom("Chalkboard SE", size: 16))
                .lineLimit(3)  // ✅ 只显示前 3 行，多余部分省略
                .truncationMode(.tail)
        }
        .padding(.vertical, 8)
    }

    /// **📌 格式化日期（YYYY/MM/DD）**
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: date)
    }
}



#Preview {
    JournalReviewView()
}

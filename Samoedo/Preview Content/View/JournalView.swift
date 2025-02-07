//
//  JournalView.swift
//  Samoedo
//
//  Created by chika on 2025/2/6.
//

import SwiftUI

struct JournalView: View {
    @StateObject var journalViewModel: JournalViewModel  // ✅ 确保 ViewModel 变量名一致
    var mainViewModel: MainViewModel  // ✅ 确保 MainViewModel 传递正确

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
            VStack {
                Spacer().navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image(systemName: "house")
                                    .foregroundColor(.brown)
                                Text("home").foregroundColor(.brown)
                            }
                        }
                    }
                }
                Spacer()
                Text(journalViewModel.morning ? "🌅 早晨日记" : "🌙 晚上日记")
                    .font(.title)
                    .padding()

                TextEditor(text: $journalViewModel.content)
                    .frame(height: 300)
                    .border(Color.gray, width: 1)
                    .padding()
            }
            
    }
}

#Preview {
    JournalView(journalViewModel: JournalViewModel(morning: true), mainViewModel: MainViewModel())
}

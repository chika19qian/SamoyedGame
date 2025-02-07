//
//  StepNavigationView.swift
//  Samoedo
//
//  Created by chika on 2025/2/7.
//

import SwiftUI

struct StepFlowView: View {
    @StateObject var viewModel = JournalViewModel()

    var body: some View {
        VStack {
            StepNavigationView(viewModel: viewModel) // ✅ 确保导航栏可见

            switch viewModel.step {
            case 1:
                Step1View(viewModel: viewModel)
                    .navigationBarBackButtonHidden(true) // ✅ 这里确保隐藏 Back 按钮
            case 2:
                Step2View(viewModel: viewModel)
                    .navigationBarBackButtonHidden(true)
            case 3:
                Step3View(viewModel: viewModel)
                    .navigationBarBackButtonHidden(true)
            case 4:
                Step4View(viewModel: viewModel)
                    .navigationBarBackButtonHidden(true)
            case 5:
                Step5View(viewModel: viewModel)
                    .navigationBarBackButtonHidden(true)
            default:
                Text("Unknown Step")
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}


struct StepNavigationView: View {
    @ObservedObject var viewModel: JournalViewModel
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        HStack {
            if viewModel.step == 1 {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.brown)
                        .font(.title)
                }
            } else {
                Button(action: { viewModel.previousStep() }) {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.brown)
                        .font(.title)
                }
            }

            Spacer()

            Text("\(viewModel.step)/5") 
                .foregroundColor(.brown)
                .font(.headline)
        }
        .padding(.horizontal)
    }
}

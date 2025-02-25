//
//  MoodStepFlowView.swift
//  Samoedo
//
//  Created by chika on 2025/2/25.
//


import SwiftUI

struct MoodStepFlowView: View {
    @StateObject var viewModel = MoodJournalViewModel()
    @ObservedObject var mainViewModel: MainViewModel

    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.91, blue: 0.84)
                .edgesIgnoringSafeArea(.all)
            VStack {
                MoodStepNavigationView(viewModel: viewModel)

                switch viewModel.step {
                case 1:
                    MoodStep1View(viewModel: viewModel)
                case 2:
                    MoodStep2View(viewModel: viewModel)
                case 3:
                    MoodStep3View(viewModel: viewModel)
                case 4:
                    MoodStep4View(viewModel: viewModel,mainViewModel:mainViewModel)
                default:
                    Text(String(localized: "Unknown Step"))
                }
            }.navigationBarHidden(true)

        }
                
    }
}

struct MoodStepNavigationView: View {
    @ObservedObject var viewModel: MoodJournalViewModel
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

            Text("\(viewModel.step)/4")
                .foregroundColor(.brown)
                .font(.headline)
        }
        .padding(.horizontal)
    }
}

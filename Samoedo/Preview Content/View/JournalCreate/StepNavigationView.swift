//
//  StepNavigationView.swift
//  Samoedo
//
//  Created by chika on 2025/2/7.
//

import SwiftUI

struct StepFlowView: View {
    @StateObject var viewModel = JournalViewModel()
    @ObservedObject var mainViewModel: MainViewModel

    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.91, blue: 0.84)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                StepNavigationView(viewModel: viewModel)

                switch viewModel.step {
                case 1:
                    Step1View(viewModel: viewModel)
                        .navigationBarBackButtonHidden(true)
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
                    Step5View(viewModel: viewModel, mainViewModel: mainViewModel)
                        .navigationBarBackButtonHidden(true)
                default:
                    Text("Unknown Step")
                        .navigationBarBackButtonHidden(true)
                }
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

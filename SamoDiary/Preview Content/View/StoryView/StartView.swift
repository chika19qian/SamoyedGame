//
//  StartView.swift
//  SamoDiary
//
//  Created by chika on 2025/2/17.
//

import SwiftUI

struct StartView: View {
    @StateObject private var vm = MainViewModel()
    @State private var isLoading = false
    @State private var nextView: ViewType

    enum ViewType {
        case opening
        case main
    }

    init() {
        _nextView = State(initialValue: MainViewModel().showOpeningScene ? .opening : .main)
    }

    var body: some View {
        Group {
            if isLoading {
                LoadingView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                isLoading = false
                            }
                        }
                    }
            } else {
                switch nextView {
                case .opening:
                    OpeningSceneView(vm: vm)
                case .main:
                    MainView(vm: vm)
                }
            }
        }
        .animation(.easeInOut, value: isLoading)
        .onChange(of: vm.showOpeningScene) { oldValue, newValue in
            if !newValue {
                startLoadingThenShow(.main)
            }
        }
        .onChange(of: vm.navigateToMain) { oldValue, newValue in
            if newValue {
                startLoadingThenShow(.main)
            }
        }
    }

    private func startLoadingThenShow(_ view: ViewType) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                self.nextView = view
                self.isLoading = false
            }
            print("✅ Loading complete, switching to: \(view)")
        }
    }
}

#Preview {
    StartView()
}


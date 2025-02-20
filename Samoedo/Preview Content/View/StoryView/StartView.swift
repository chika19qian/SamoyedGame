//
//  StartView.swift
//  Samoedo
//
//  Created by chika on 2025/2/17.
//

import SwiftUI

struct StartView: View {
    @StateObject private var vm = MainViewModel()

    var body: some View {
        Group {
            if vm.showOpeningScene {
                OpeningSceneView(vm: vm)
            } else {
                MainView(vm: vm)
            }
        }
    }
}

#Preview {
    StartView()
}

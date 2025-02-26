//
//  AnimatedImageView.swift
//  SamoDiary
//
//  Created by chika on 2025/2/24.
//

import SwiftUI

struct AnimatedImageView: View {
    let folderName: String
    @State private var frameCount: Int = 6 
    @State private var currentFrame: Int = 0
    @State private var timer: Timer?

    var body: some View {
        Image("\(folderName)_\(currentFrame)")
            .resizable()
            .scaledToFit()
            .frame(width: 450, height: 450)
            .opacity(1)
            .onAppear {
                startAnimation()
            }
            .onDisappear {
                stopAnimation()
            }
    }

    func startAnimation() {
        stopAnimation()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            DispatchQueue.main.async {
                currentFrame = (currentFrame + 1) % frameCount
            }
        }
    }

    func stopAnimation() {
        timer?.invalidate()
        timer = nil
    }
}



//
//  Loading.swift
//  Samoedo
//
//  Created by chika on 2025/2/17.
//

import SwiftUI

struct LoadingView: View {
    @State private var progress: CGFloat = 0.0  

    var body: some View {
        ZStack {
            Color.brown.opacity(0.9)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("🐾 Getting things ready...")
                    .font(.custom("Chalkboard SE", size: 22))
                    .foregroundColor(.white)
                    .padding(.top, 20)

                ProgressBar(progress: progress)
                    .frame(width: 250, height: 20)
                    .padding()

                Text("\(Int(progress * 100))%")
                    .font(.custom("Chalkboard SE", size: 18))
                    .foregroundColor(.white)

                Spacer()
            }
        }
        .onAppear {
            startLoading()
        }
    }

    /// **📌 模拟加载进度**
    private func startLoading() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if self.progress < 1.0 {
                self.progress += 0.05
            } else {
                timer.invalidate()
            }
        }
    }
}


struct ProgressBar: View {
    var progress: CGFloat

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white.opacity(0.3))
                .frame(height: 20)

            RoundedRectangle(cornerRadius: 10)
                .fill(Color.yellow)
                .frame(width: 250 * progress, height: 20)

            HStack {
                Spacer()
                    .frame(width: 250 * progress - 20) 
                Text("🐾")
                    .font(.system(size: 16))
            }
        }
    }
}

#Preview {
    LoadingView()
}

//
//  Helpers.swift
//  Samoedo
//
//  Created by chika on 2025/2/6.
//

import Foundation
import SwiftUI
import UIKit


func setupNavigationBarAppearance() {
    UINavigationBar.appearance().largeTitleTextAttributes = [
        .font: UIFont(name: "Chalkboard SE", size: 28)!
    ]
    UINavigationBar.appearance().titleTextAttributes = [
        .font: UIFont(name: "Chalkboard SE", size: 22)!
    ]
}

func calcTimeSince(data: Date) -> Int {
    let timeInterval = Date().timeIntervalSince(data)
    return Int(timeInterval)
}

extension View{
    func centerH() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
    
    func chalkboardFont(size: CGFloat) -> some View {
        self.font(.custom("Chalkboard SE", size: size))
    }
    
}

struct VerticalBrownProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                // 背景 (浅褐色)
                RoundedRectangle(cornerRadius: geometry.size.width / 2)
                    .fill(Color.brown.opacity(0.3))
                    .frame(width: geometry.size.width, height: geometry.size.height)

                // 进度部分 (深褐色)
                RoundedRectangle(cornerRadius: geometry.size.width / 2)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.brown, Color.brown.opacity(0.7)]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height * CGFloat(configuration.fractionCompleted ?? 0)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: geometry.size.width / 2))
            }
        }
    }
}


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
    print("🔍 Setting up Navigation Bar Appearance...")
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()  

    if let titleFont = UIFont(name: "Chalkboard SE", size: 28),
       let subtitleFont = UIFont(name: "Chalkboard SE", size: 22) {
        appearance.largeTitleTextAttributes = [.font: titleFont]
        appearance.titleTextAttributes = [.font: subtitleFont]
    } else {
        print("⚠️ Warning: Chalkboard SE font not found")
    }

    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance

    print("✅ Navigation Bar Appearance Set Successfully")
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

struct KeyboardAwareModifier: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight) // ✅ 根据键盘高度调整布局
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                    if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                        withAnimation {
                            self.keyboardHeight = keyboardFrame.height * 0.6 // ✅ 只移动 60% 避免 UI 过度上移
                        }
                    }
                }

                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    withAnimation {
                        self.keyboardHeight = 0
                    }
                }
            }
    }
}

extension View {
    func keyboardAware() -> some View {
        self.modifier(KeyboardAwareModifier())
    }
}


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
    let seconds = Int(-data.timeIntervalSinceNow)
    return seconds
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

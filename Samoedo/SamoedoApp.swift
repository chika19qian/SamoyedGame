//
//  SamoedoApp.swift
//  Samoedo
//
//  Created by chika on 2025/2/6.
//

import SwiftUI
import SwiftData

@main
struct SamoedoApp: App {
    init() {
        print("✅ App is launching...")
        setupNavigationBarAppearance()
    }

    var body: some Scene {
        WindowGroup {
            StartView()
        }
    }
}

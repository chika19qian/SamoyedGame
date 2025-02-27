//
//  Outdoor.swift
//  SamoDiary
//
//  Created by chika on 2025/2/25.
//

import SwiftUI

struct Outdoor: View {
    var body: some View {
        ZStack {
            Image("Forest")
                .edgesIgnoringSafeArea(.all)
            Text("New Scene Coming Soon!")
                .chalkboardFont(size: 35)
                .foregroundColor(.white)
            //Text("你好啊1234abcd")
                .chalkboardFont(size: 35)
                .foregroundColor(.white)
        }
        
    }
}

#Preview {
    Outdoor()
}

//
//  TextFormatter.swift
//  SamoDiary
//
//  Created by chika on 2025/2/27.
//


import SwiftUI

import SwiftUI

struct TextFormatter {
    static func parse(_ message: String) -> AttributedString {
        var attributedString = AttributedString()
        
        let components = message.components(separatedBy: "{bold}")

        for (index, part) in components.enumerated() {
            if index % 2 == 0 {
                // 普通文本部分
                attributedString.append(AttributedString(part))
            } else {
                // 需要加粗变色的部分
                var boldText = AttributedString(part)
                boldText.font = .custom("Chalkboard SE", size: 24).bold()
                boldText.foregroundColor = .yellow
                attributedString.append(boldText)
            }
        }
        
        return attributedString
    }
}


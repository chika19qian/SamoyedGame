//
//  Item.swift
//  Samoedo
//
//  Created by chika on 2025/2/6.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

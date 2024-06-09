//
//  Item.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 09.06.2024.
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
 

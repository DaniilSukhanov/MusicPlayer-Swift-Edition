//
//  PlayerItem.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 08.07.2024.
//

import Foundation

struct PlayerItem: Sendable, Equatable {
    let audio: Data
    let model: ShortlyTrackModel
    
    static func == (lhs: PlayerItem, rhs: PlayerItem) -> Bool {
        lhs.model.backendyID == rhs.model.backendyID
    }
}

//
//  PlayerAction.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 08.07.2024.
//

import Foundation

enum PlayerAction: ActionProtocol {
    case play, stop
    case addPlayerItem(PlayerItem)
    case removePlayerItem(PlayerItem)
    case moveSlider(to: TimeInterval)
    case updateCurrentTime
}

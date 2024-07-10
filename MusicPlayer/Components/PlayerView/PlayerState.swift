//
//  PlayerState.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 08.07.2024.
//

import Foundation
import AVFoundation

struct PlayerState: StateProtocol {
    var queue = AudioQueueManager<PlayerItem>()
    var currentTime: TimeInterval?
    var isPlaying = false
    var player: AVAudioPlayer?
}

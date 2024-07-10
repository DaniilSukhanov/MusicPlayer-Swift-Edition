//
//  PlayerReducer.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 08.07.2024.
//

import Foundation
import AVFoundation

@MainActor func playerReducer(_ state: inout PlayerState, _ action: PlayerAction) {
    switch action {
    case .addPlayerItem(let item):
        state.queue.add(audio: item)
        state.player = try! AVAudioPlayer(data: item.audio)
        state.player?.prepareToPlay()
        state.player?.play()
    case .moveSlider(to: let position):
        state.player?.currentTime = position
    case .updateCurrentTime:
        state.isPlaying = state.player?.isPlaying ?? false
        state.currentTime = state.player?.currentTime
    case .stop:
        state.player?.stop()
    case .play:
        state.player?.play()
    default:
        break
    }
}

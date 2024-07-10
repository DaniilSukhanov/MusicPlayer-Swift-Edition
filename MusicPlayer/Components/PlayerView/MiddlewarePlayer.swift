//
//  MiddlewarePlayer.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 08.07.2024.
//

import Foundation

func middlewarePlayer() -> Middleware<PlayerState, PlayerAction> {
    return { state, action in
        switch action {
        case .updateCurrentTime:
            if await state.isPlaying {
                try? await Task.sleep(for: .seconds(0.5))
                return .updateCurrentTime
            }
            return nil
        case .play:
            return .updateCurrentTime
        default:
            return nil
        }
    }
}


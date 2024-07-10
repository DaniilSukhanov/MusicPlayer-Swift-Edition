//
//  MiddlewareRoot.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 17.06.2024.
//

import Foundation

func middlewareRoot() -> Middleware<RootState, RootAction> {
    let mainPage = middlewareMainPage()
    let middlewarePlayer = middlewarePlayer()

    return { state, action in
        switch action {
        case .mainPageReducer(action: let action):
            guard let newAction = await mainPage(state.mainPageState, action) else {
                return nil
            }
            return .mainPageReducer(action: newAction)
        case .player(action: let action):
            guard let newAction = await middlewarePlayer(state.playerState, action) else {
                return nil
            }
            return .player(action: newAction)
        default:
            break
        }
        return nil
    }
}

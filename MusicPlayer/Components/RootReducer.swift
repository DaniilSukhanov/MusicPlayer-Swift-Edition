//
//  RootReducer.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 15.06.2024.
//

import Foundation

@MainActor func rootReducer(_ state: inout RootState, _ action: RootAction) {
    switch action {
    case .welcomeView(action: let action):
        welcomeViewReducer(&state.welcomeViewState, action)
    case .mainPageReducer(action: let action):
        mainPageReducer(&state.mainPageState, action)
    case .player(action: let action):
        playerReducer(&state.playerState, action)
    }
}

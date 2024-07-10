//
//  RootState.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 15.06.2024.
//

import AVFoundation

struct RootState: StateProtocol {
    var welcomeViewState = WelcomeViewState()
    var mainPageState = MainPageState()
    var playerState = PlayerState()
}

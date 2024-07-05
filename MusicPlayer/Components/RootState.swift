//
//  RootState.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 15.06.2024.
//

import AVFoundation

@MainActor
struct RootState: StateProtocol {
    var welcomeViewState = WelcomeViewState()
    var mainPageState = MainPageState()
}

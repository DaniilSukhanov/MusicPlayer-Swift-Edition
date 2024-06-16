//
//  RootState.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 15.06.2024.
//

import Foundation

struct RootState: StateProtocol {
    var welcomeViewState = WelcomeViewState()
    var mainPageState = MainPageState()
}

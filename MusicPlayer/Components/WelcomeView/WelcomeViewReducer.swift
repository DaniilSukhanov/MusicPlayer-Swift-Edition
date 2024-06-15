//
//  WelcomeViewReducer.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 15.06.2024.
//

import Foundation

@MainActor func welcomeViewReducer(_ state: inout WelcomeViewState, _ action: WelcomeViewAction) {
    switch action {
    case .continue:
        state.isShowWelcomeView = false
    }
}

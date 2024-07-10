//
//  RootAction.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 15.06.2024.
//

import Foundation

enum RootAction: ActionProtocol {
    case welcomeView(action: WelcomeViewAction)
    case mainPageReducer(action: MainPageAction)
    case player(action: PlayerAction)
}

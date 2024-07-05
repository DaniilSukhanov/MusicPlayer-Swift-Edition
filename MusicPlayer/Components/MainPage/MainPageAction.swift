//
//  MainPageAction.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 16.06.2024.
//

import Foundation

enum MainPageAction: ActionProtocol {
    case search(String, `type`: MusicService.TypeSearch)
    case setContent([ContentConteiner])
    case searchPlaylist(String)
}

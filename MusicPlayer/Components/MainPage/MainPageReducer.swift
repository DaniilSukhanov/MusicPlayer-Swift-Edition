//
//  MainPageReducer.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 16.06.2024.
//

import Foundation

@MainActor func mainPageReducer(_ state: inout MainPageState, _ action: MainPageAction) {
    switch action {
    case .search(_), .searchPlaylist(_):
        break
    case .setContent(let content):
        state.content = content
    }
}

//
//  MainPageMiddleware.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 17.06.2024.
//

import Foundation

func middlewareMainPage() -> Middleware<MainPageState, MainPageAction> {
    let musicService = MusicService.shared
    
    return { state, action in
        switch action {
        case .search(let queary):
            do {
                guard let content = try await musicService.search(queary, type: "tracks", offset: 0, limit: 10) else {
                    return nil
                }
                return .setContent(content)
            } catch {
                return nil
            }
        default:
            break
        }
        return nil
    }
}

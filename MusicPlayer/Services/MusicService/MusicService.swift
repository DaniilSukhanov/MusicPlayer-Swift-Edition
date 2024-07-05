//
//  MusicService.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 10.06.2024.
//

import SwiftUI

protocol MusicServiceProtocol {
    associatedtype Strategy: MusicServiceStrategyProtocol
    associatedtype ContentItem
    associatedtype TypeSearch: Sendable
    
    var strategy: Strategy { get }
    
    func search(_ quare: String, type: TypeSearch, offset: Int, limit: Int) async throws -> ContentItem
}

@globalActor
actor MusicService: MusicServiceProtocol {
    typealias Strategy = RapidSpotifyStrategy
    typealias ContentItem = Strategy.RapidSpotifyItem
    typealias TypeSearch = MSTypeSearch
    
    static let shared = {
        let strategy = RapidSpotifyStrategy(baseURL: NonSecretAccessData.urlMusicService)
        return MusicService(strategy: strategy)
    }()
    
    let strategy: Strategy
    
    func search(_ quare: String, type: TypeSearch, offset: Int, limit: Int) async throws -> ContentItem {
        try await strategy.search(quare, type: type.rawValue, offset: offset, limit: limit)
    }
    
    init(strategy: Strategy) {
        self.strategy = strategy
    }
}

extension MusicService {
    enum MSTypeSearch: String {
        case tracks, playlists
    }
}


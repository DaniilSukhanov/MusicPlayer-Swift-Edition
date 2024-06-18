//
//  MusicService.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 10.06.2024.
//

import SwiftUI

protocol MusicServiceProtocol {
    associatedtype Strategy = any MusicServiceStrategyProtocol
    
    var strategy: Strategy { get }
    
    func search(_ quare: String, type: String, offset: Int, limit: Int) async throws -> [ContentModel]?
}

extension MusicServiceProtocol {
    
}

@globalActor
actor MusicService: MusicServiceProtocol {
    typealias Strategy = RapidSpotifyStrategy
    typealias TypeSorted = TypeSort
    
    static let shared = {
        let strategy = RapidSpotifyStrategy(baseURL: NonSecretAccessData.urlMusicService)
        return MusicService(strategy: strategy)
    }()
    
    let strategy: Strategy
    
    func search(_ quare: String, type: String, offset: Int, limit: Int) async throws -> [ContentModel]? {
        let data = try await strategy.search(quare, type: type, offset: offset, limit: limit)
        var result: [ContentModel]?
        if let data = data as? Strategy.Tracks {
            result = await withTaskGroup(of: ContentModel.self, returning: [ContentModel].self) { group in
                for item in data.items {
                    group.addTask {
                        let seconds = item.duration.totalMilliseconds / 1000
                        let duration = String(format: "%02d:%02d", seconds / 60, seconds % 60)
                        var image = AppImage.noImage
                        if let urlImage = item.albumOfTrack.coverArt.sources.max(by: { item1, item2 in
                            min(item1.height, item1.width) < min(item2.height, item2.width)
                        }) {
                            image = (try? await URL(string: urlImage.url)?.getImage()) ?? AppImage.noImage
                        }
                        return ContentModel(
                            name: item.name,
                            id: item.id,
                            image: image,
                            type: .track,
                            artists: item.artists.items.compactMap { artist in
                                .init(id: artist.profile.name, name: artist.profile.name)
                            },
                            duration: duration
                        )
                    }
                }
                var result = [ContentModel]()
                for await content in group {
                    result.append(content)
                }
                result.sort { item1, item2 in
                    item1.id < item2.id
                }
                return result
            }
        }
        return result
    }
    
    init(strategy: Strategy) {
        self.strategy = strategy
    }
}

extension MusicService {
    enum MusicServiceError: Error {
        
    }
}

extension MusicService {
    enum TypeSort {
       
        case track
    }
}


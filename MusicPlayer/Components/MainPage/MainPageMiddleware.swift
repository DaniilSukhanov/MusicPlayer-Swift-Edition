//
//  MainPageMiddleware.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 17.06.2024.
//

import Foundation
import OSLog

func middlewareMainPage() -> Middleware<MainPageState, MainPageAction> {
    let musicService = MusicService.shared
    let logger = Logger(subsystem: #function, category: "Middleware")
    
    return { state, action in
        switch action {
        case .search(let queary, let type):
            do {
                let result = try await musicService.search(queary, type: type, offset: 0, limit: 10)
                var content: [any ContentProtocol]?
                if let data = result as? MusicService.Strategy.Tracks {
                    content = await getTracks(data: data)
                } else if let data = result as? MusicService.Strategy.Playlists {
                    content =  await getPlaylists(data: data)
                }
                if let content {
                    return .setContent(content.compactMap(ContentConteiner.init))
                }
                return .setContent([])
            } catch {
                logger.error("error \"\(error.localizedDescription)\": \(String(describing: error))")
                return nil
            }
        default:
            return nil
        }
    }
}

fileprivate func getPlaylists(data: MusicService.Strategy.Playlists) async -> [any ContentProtocol] {
    await withTaskGroup(of: (any ContentProtocol).self, returning: [any ContentProtocol].self) { group in
        for item in data.items {
            guard let item = item.data else {
                continue
            }
            
            group.addTask {
                var image = AppImage.noImage
                if let string = item.images.items.first?.sources.first?.url, let url = URL(string: string) {
                    image = (try? await url.getImage()) ?? AppImage.noImage
                }
                return ShortlyPlaylistModel(
                    backendyID: item.uri,
                    name: item.name,
                    artists: [],
                    image: image
                )
            }
        }
        var result = [String: any ContentProtocol]()
        for await content in group {
            result[content.backendyID] = content
        }
        return data.items.compactMap({ $0.data?.uri }).compactMap { result[$0] }
    }
}

fileprivate func getTracks(data: MusicService.Strategy.Tracks) async -> [any ContentProtocol] {
    await withTaskGroup(of: (any ContentProtocol).self, returning: [any ContentProtocol].self) { group in
        for item in data.items {
            group.addTask {
                let seconds = item.duration.totalMilliseconds / 1000
                let duration = String(format: "%02d:%02d", seconds / 60, seconds % 60)
                var image = AppImage.noImage
                if let urlImage = item.albumOfTrack.coverArt.sources.max(by: { item1, item2 in
                    min(item1.height ?? 0, item1.width ?? 0) < min(item2.height ?? 0, item2.width ?? 0)
                }) {
                    image = (try? await URL(string: urlImage.url)?.getImage()) ?? AppImage.noImage
                }
                return ShortlyTrackModel(
                    backendyID: item.id,
                    name: item.name,
                    artists: item.artists.items.compactMap({ ShortyInfoArtist(id: $0.profile.name, name: $0.profile.name) }),
                    duration: duration,
                    image: image
                )
            }
        }
        var result = [String: any ContentProtocol]()
        for await content in group {
            result[content.backendyID] = content
        }
        return data.items.compactMap({ $0.id }).compactMap { result[$0] }
    }
}

//
//  RapidSpotifyStrategy+Playlists.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 19.06.2024.
//

import Foundation

extension RapidSpotifyStrategy {
    // MARK: - Playlists
    struct Playlists: Decodable, Sendable, RapidSpotifyItem {
        enum RootCodingKeys: CodingKey {
            case playlists
        }
        
        enum PlaylistsCodingKeys: CodingKey {
            case totalCount, items, pagingInfo
        }
        
        let totalCount: Int
        let items: [PlaylistsItem]
        let pagingInfo: PagingInfo
        
        enum CodingKeys: CodingKey {
            case totalCount
            case items
            case pagingInfo
        }
        
        init(from decoder: any Decoder) throws {
            let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
            let playlistContainer = try rootContainer.nestedContainer(keyedBy: PlaylistsCodingKeys.self, forKey: .playlists)
            totalCount = try playlistContainer.decode(Int.self, forKey: .totalCount)
            items = try playlistContainer.decode([PlaylistsItem].self, forKey: .items)
            pagingInfo = try playlistContainer.decode(PagingInfo.self, forKey: .pagingInfo)
        }
    }

    // MARK: - PlaylistsItem
    struct PlaylistsItem: Decodable, Sendable {
        // MARK: - DataClass
        struct DataClass: Decodable, Sendable {
            let uri, name, description: String
            let images: Images
            let owner: Owner
        }
        
        let data: DataClass?
        
        enum CodingKeys: String, CodingKey {
            case data
        }
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            data = try? container.decode(DataClass.self, forKey: .data)
        }
    }

    // MARK: - Images
    struct Images: Decodable, Sendable {
        let items: [ImagesItem]
    }

    // MARK: - ImagesItem
    struct ImagesItem: Decodable, Sendable {
        let sources: [Source]
    }

    // MARK: - Owner
    struct Owner: Decodable, Sendable {
        let name: String
    }
}

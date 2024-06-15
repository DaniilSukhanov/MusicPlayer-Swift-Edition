//
//  RapidSpotifyStrategy+Models.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 10.06.2024.
//

import Foundation

extension RapidSpotifyStrategy {
    protocol RapidSpotifyItem: Sendable { }
    
    // MARK: - Tracks
    struct Tracks: Decodable, RapidSpotifyItem, Sendable {
        let totalCount: Int
        let items: [TracksItem]
        let pagingInfo: PagingInfo
        
        enum CodingKeys: CodingKey {
            case totalCount
            case items
            case pagingInfo
        }
        
        enum InputCodingKeys: CodingKey {
            case tracks
        }
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: InputCodingKeys.self)
            let tracks = try container.decode(Tracks.self, forKey: .tracks)
            self.totalCount = tracks.totalCount
            self.items = tracks.items
            self.pagingInfo = tracks.pagingInfo
        }
    }

    // MARK: - TracksItem
    struct TracksItem: Decodable, Sendable {
        // MARK: - DataClass
        struct DataClass: Decodable, Sendable {
            let uri, id, name: String
            let albumOfTrack: AlbumOfTrack
            let artists: Artists
            let contentRating: ContentRating
            let duration: Duration
            let playability: Playability
        }
        
        let uri, id, name: String
        let albumOfTrack: AlbumOfTrack
        let artists: Artists
        let contentRating: ContentRating
        let duration: Duration
        let playability: Playability
        
        enum CodingKeys: CodingKey {
            case data
        }
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let data = try container.decode(DataClass.self, forKey: CodingKeys.data)
            uri = data.uri
            id = data.id
            albumOfTrack = data.albumOfTrack
            artists = data.artists
            contentRating = data.contentRating
            playability = data.playability
            duration = data.duration
            name = data.name
        }
    }

    // MARK: - AlbumOfTrack
    struct AlbumOfTrack: Decodable, Sendable {
        let uri, name: String
        let coverArt: CoverArt
        let id: String
        let sharingInfo: SharingInfo
    }

    // MARK: - CoverArt
    struct CoverArt: Decodable, Sendable {
        let sources: [Source]
    }

    // MARK: - Source
    struct Source: Decodable, Sendable {
        let url: String
        let width, height: Int
    }

    // MARK: - SharingInfo
    struct SharingInfo: Decodable, Sendable {
        let shareURL: String
    }

    // MARK: - Artists
    struct Artists: Decodable, Sendable {
        let items: [ArtistsItem]
    }

    // MARK: - ArtistsItem
    struct ArtistsItem: Decodable, Sendable {
        let uri: String
        let profile: Profile
    }

    // MARK: - Profile
    struct Profile: Decodable, Sendable {
        let name: String
    }

    // MARK: - ContentRating
    struct ContentRating: Decodable, Sendable {
        let label: Label
    }

    enum Label: String, Decodable, Sendable {
        case explicit
        case none
    }

    // MARK: - Duration
    struct Duration: Decodable, Sendable {
        let totalMilliseconds: Int
    }

    // MARK: - Playability
    struct Playability: Decodable, Sendable {
        let playable: Bool
    }

    // MARK: - PagingInfo
    struct PagingInfo: Decodable, Sendable {
        let nextOffset, limit: Int
    }
}

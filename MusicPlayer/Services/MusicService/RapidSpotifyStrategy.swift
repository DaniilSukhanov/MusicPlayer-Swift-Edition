//
//  RapidSpotifyStrategy.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 10.06.2024.
//

@preconcurrency import Foundation

protocol MusicServiceStrategyProtocol: NetworkingProtocol {
    associatedtype T
    associatedtype MusicServiceItem
    
    func search(_ quare: String, type: T, offset: Int, limit: Int) async throws -> MusicServiceItem
}

actor RapidSpotifyStrategy: MusicServiceStrategyProtocol {
    let baseURL: String
    private let decoder = {
        JSONDecoder()
    }()
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func search(_ quare: String, type: TypeSearch, offset: Int, limit: Int) async throws -> RapidSpotifyItem {
        let queryItems = [URLQueryItem(name: "offset", value: String(offset)), URLQueryItem(name: "limit", value: String(limit))]
        var components = URLComponents(string: "\(baseURL)/search")
        components?.queryItems = queryItems
        guard let url = components?.url else {
            throw RapidSpotifyStrategyError.notCorrrectURL
        }
        let request = URLRequest(url: url)
        let (data, responce) = try await URLSession.shared.data(for: request)
        guard let statusCode = (responce as? HTTPURLResponse)?.statusCode else {
            throw RapidSpotifyStrategyError.notCorrectStatusCode
        }
        if statusCode != 200 {
            throw RapidSpotifyStrategyError.errorResponce(responce)
        }
        let result = try decoder.decode(Tracks.self, from: data)
        return result
    }
    
}

extension RapidSpotifyStrategy {
    enum TypeSearch: String {
        case multi, albums, artists
        case episodes, genres, playlists
        case podcasts, tracks, users
    }
}

extension RapidSpotifyStrategy {
    enum RapidSpotifyStrategyError: Error {
        case notCorrrectURL
        case errorResponce(URLResponse)
        case notCorrectStatusCode
    }
}

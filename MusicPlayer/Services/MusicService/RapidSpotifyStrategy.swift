//
//  RapidSpotifyStrategy.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 10.06.2024.
//

@preconcurrency import Foundation

protocol MusicServiceStrategyProtocol: NetworkingProtocol, Actor {
    associatedtype MusicServiceItem
    
    func search(_ quare: String, type: String, offset: Int, limit: Int) async throws -> MusicServiceItem
}

actor RapidSpotifyStrategy: MusicServiceStrategyProtocol {
    let baseURL: String
    private let decoder = {
        JSONDecoder()
    }()
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    private func addAPIKey(request: inout URLRequest) {
        request.setValue(NonSecretAccessData.apikeyMusicService, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue("spotify23.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
    }
    
    func search(_ quare: String, type: String, offset: Int, limit: Int) async throws -> RapidSpotifyItem {
        let queryItems = [
            URLQueryItem(name: "q", value: quare),
            URLQueryItem(name: "type", value: type),
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "limit", value: String(limit))
        ]
        var components = URLComponents(string: "\(baseURL)/search")
        components?.queryItems = queryItems
        guard let url = components?.url else {
            throw RapidSpotifyStrategyError.notCorrrectURL
        }
        var request = URLRequest(url: url)
        addAPIKey(request: &request)
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
    enum RapidSpotifyStrategyError: Error {
        case notCorrrectURL
        case errorResponce(URLResponse)
        case notCorrectStatusCode
    }
}

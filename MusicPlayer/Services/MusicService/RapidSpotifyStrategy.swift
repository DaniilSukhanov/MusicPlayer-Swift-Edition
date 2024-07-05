//
//  RapidSpotifyStrategy.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 10.06.2024.
//

@preconcurrency import Foundation
import OSLog

protocol MusicServiceStrategyProtocol: NetworkingProtocol, Actor {
    associatedtype MusicServiceItem
    
    func search(_ quare: String, type: String, offset: Int, limit: Int) async throws -> MusicServiceItem
}

actor RapidSpotifyStrategy: MusicServiceStrategyProtocol {
    let baseURL: String
    private let logger = Logger(subsystem: #function, category: "Networking")
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
        logger.debug("request \(url.absoluteString)")
        var request = URLRequest(url: url)
        addAPIKey(request: &request)
        let (data, responce) = try await URLSession.shared.data(for: request)
        guard let statusCode = (responce as? HTTPURLResponse)?.statusCode else {
            throw RapidSpotifyStrategyError.notCorrectStatusCode
        }
        if statusCode != 200 {
            throw RapidSpotifyStrategyError.errorResponce(responce)
        }
        var result: RapidSpotifyItem
        do {
            switch type {
            case "tracks":
                result = try decoder.decode(Tracks.self, from: data)
            case "playlists":
                result = try decoder.decode(Playlists.self, from: data)
            default:
                throw RapidSpotifyStrategyError.notCorrectType(type)
            }
        } catch let error where error is DecodingError {
            logger.debug("json: \(data.prettyJSON ?? "not json")")
        
            throw RapidSpotifyStrategyError.invalidJSON(error)
        }
        return result
    }
    
}

extension RapidSpotifyStrategy {
    enum RapidSpotifyStrategyError: Error {
        case notCorrrectURL
        case errorResponce(URLResponse)
        case notCorrectStatusCode
        case notCorrectType(String)
        case invalidJSON(Error)
    }
}

//
//  NonSecretAccessData.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 17.06.2024.
//

import Foundation

struct NonSecretAccessData {
    fileprivate static let json: [String: String]? = {
        do {
            guard let path = Bundle.main.path(forResource: "apikey", ofType: "json") else {
                return nil
            }
            let data = try Data(contentsOf: URL(filePath: path), options: .uncached)
            return try JSONSerialization.jsonObject(with: data) as? [String: String]
        } catch {
            return nil
        }
    }()
    
    static let apikeyMusicService = json?["api_key_music_service"] ?? "Not"
    static let urlMusicService = "https://spotify23.p.rapidapi.com"
}

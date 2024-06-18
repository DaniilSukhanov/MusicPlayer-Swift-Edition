//
//  URL+getImage.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 18.06.2024.
//

import SwiftUI

enum URLError: Error {
    case babURL
}

@globalActor
actor CacheImage {
    private let cache = NSCache<NSURL, UIImage>()
    
    static let shared = CacheImage()
    
    func get(url: URL) async throws -> Image {
        if let image = cache.object(forKey: url as NSURL) {
            return Image(uiImage: image)
        }
        let image = try await url.getUIImage()
        cache.setObject(image, forKey: url as NSURL)
        return Image(uiImage: image)
    }
}



extension URL {
    func getImage() async throws -> Image {
        try await CacheImage.shared.get(url: self)
    }
    
    fileprivate func getUIImage() async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: self)
        guard let uiimage = UIImage(data: data) else {
            throw URLError.babURL
        }
        return uiimage
    }
}

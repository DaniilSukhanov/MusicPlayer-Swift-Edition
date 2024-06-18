//
//  CacheImageManager.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 18.06.2024.
//

import SwiftUI

@globalActor
actor CacheImageManager {
    
    static let shared = CacheImageManager()
    
    private let cache = NSCache<NSString, NSDate>()
    
    subscript(id: String) -> ContentModel? {
        return nil
    }
    
}

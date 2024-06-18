//
//  ContentModel.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 16.06.2024.
//

import SwiftUI

struct ContentModel: Identifiable {
    let name: String
    let id: String
    let image: Image
    let `type`: `Type`
    let artists: [Artist]
    let duration: String?
}

extension ContentModel {
    enum `Type`: String {
        case track, playlist
    }
}

extension ContentModel {
    struct Artist: Identifiable {
        let id: String
        let name: String
    }
    
}

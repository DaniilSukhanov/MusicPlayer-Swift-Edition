//
//  ShortlyPlaylistModel.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 05.07.2024.
//

import SwiftUI

struct ShortlyPlaylistModel: ContentProtocol {
    let backendyID: String
    let name: String
    let artists: [ShortyInfoArtist]
    let image: Image
}

//
//  ShortlyTrackModel.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 05.07.2024.
//

import SwiftUI

struct ShortlyTrackModel: ContentProtocol {
    let backendyID: String
    let name: String
    let artists: [ShortyInfoArtist]
    let duration: String
    let image: Image
}

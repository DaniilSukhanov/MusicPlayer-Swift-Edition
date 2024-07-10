//
//  loadTestAudio.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 08.07.2024.
//

import Foundation

func loadTestAudio() -> Data? {
    guard let path = Bundle.main.path(forResource: "audio_test", ofType: "mp3") else {
        return nil
    }
    let data = try? Data(contentsOf: URL(filePath: path), options: .uncached)
    return data
}

//
//  ContentConteiner.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 05.07.2024.
//

import Foundation

struct ContentConteiner: Identifiable {
    var id: String {
        value.id
    }
    let value: any ContentProtocol
    
    init(_ value: any ContentProtocol) {
        self.value = value
    }
}

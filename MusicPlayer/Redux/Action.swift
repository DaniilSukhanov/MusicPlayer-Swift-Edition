//
//  Action.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 10.06.2024.
//

import Foundation

protocol ActionProtocol: Sendable {
    
}

extension ActionProtocol {
    var description: String {
        String(describing: self)
    }
}

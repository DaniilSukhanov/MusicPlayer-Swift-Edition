//
//  MusicServiceProtocol.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 10.06.2024.
//

import Foundation


protocol MusicServiceProtocol: Actor {
    var strategy: (any MusicServiceStrategyProtocol)? { get set }
    
    func search(_ quare: String, type: Any, offset: Int)
}



//
//  NetworkingProtocol.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 10.06.2024.
//

import Foundation

protocol NetworkingProtocol: Actor {
    var baseURL: String { get }
    
    init(baseURL: String)
}



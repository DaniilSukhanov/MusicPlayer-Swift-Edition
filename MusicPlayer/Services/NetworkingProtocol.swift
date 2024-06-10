//
//  NetworkingProtocol.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 10.06.2024.
//

import Foundation

protocol NetworkingProtocol: Actor, CustomStringConvertible {
    var url: URL? { get }
    
    init(url: URL?)
}

extension NetworkingProtocol {
    var description: String {
        "<\(String(describing: type(of: self))): \(self.url?.absoluteString ?? "Not correct url")>"
    } 
}



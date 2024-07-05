//
//  ContentProtocol.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 05.07.2024.
//

import Foundation

protocol ContentProtocol: Identifiable, Sendable {
    var backendyID: String { get }
}

extension ContentProtocol {
    var id: String {
        "\(self.backendyID)-\(String(describing: self))"
    }
}

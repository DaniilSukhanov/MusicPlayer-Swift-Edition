//
//  PaddingManager.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 18.06.2024.
//

import SwiftUI

@MainActor
final class PaddingManager<Item> {
    private(set) var store = [Item]()
    
    func addItems(_ items: [Item]) {
        store += items
    }
    
    func clear() {
        store.removeAll()
    }
}


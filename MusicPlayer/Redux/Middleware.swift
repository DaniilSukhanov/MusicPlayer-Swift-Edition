//
//  Middleware.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 10.06.2024.
//

import Foundation

typealias Middleware<AppState: Sendable, AppAction: Sendable> = (AppState, AppAction) async -> AppAction?

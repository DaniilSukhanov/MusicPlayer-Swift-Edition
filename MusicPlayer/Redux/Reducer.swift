//
//  Reducer.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 10.06.2024.
//

import Foundation

typealias Reducer<AppState: Sendable, AppAction: Sendable> = @MainActor (inout AppState, AppAction) -> ()

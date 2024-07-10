//
//  Store+create.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 06.07.2024.
//

import Foundation

typealias RootStore = Store<RootState, RootAction>

@MainActor func createRootStore() -> RootStore {
    RootStore(
        state: RootState(),
        reducer: rootReducer,
        middlewares: [middlewareRoot(), middlewareLog()]
    )
}


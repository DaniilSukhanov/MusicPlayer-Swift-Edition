//
//  Store.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 10.06.2024.
//

import Foundation
import SwiftUI
import Observation

// Класс для хранение, чтения состояния, а также для безопасного изменение состояния на главном потоке
@MainActor
final class Store<AppState: StateProtocol, AppAction: ActionProtocol>: ObservableObject {
    private(set) var state: AppState
    private let reducer: Reducer<AppState, AppAction>
    private let middlewares: [Middleware<AppState, AppAction>]
    
    init(state: AppState, reducer: @escaping Reducer<AppState, AppAction>, middlewares: [Middleware<AppState, AppAction>]) {
        self.state = state
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
    // Измененят состояние по переданому действию
    nonisolated func dispatch(_ action: AppAction, animation: Animation? = nil) {
        Task {
            await executeAction(action, animation: animation)
        }
    }
    
    private func executeAction(_ action: AppAction, animation: Animation? = nil) async {
        reducer(&state, action)
        withAnimation(animation) {
            objectWillChange.send()
        }
        for middleware in middlewares {
            Task {
                guard let newAction = await middleware(state, action) else {
                    return
                }
                await executeAction(newAction, animation: animation)
            }
        }
    }
}

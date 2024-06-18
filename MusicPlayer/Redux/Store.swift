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
    nonisolated func dispatch(_ action: AppAction) {
        Task {
            await executeAction(action)
        }
    }
    
    private func executeAction(_ action: AppAction) async {
        reducer(&state, action)
        withAnimation {
            objectWillChange.send()
        }
        for middleware in middlewares {
            Task {
                guard let newAction = await middleware(state, action) else {
                    return
                }
                await executeAction(newAction)
                /*
                self.reducer(&state, newAction)
                withAnimation {
                    objectWillChange.send()
                }
                 */
                
            }
        }
    }
}

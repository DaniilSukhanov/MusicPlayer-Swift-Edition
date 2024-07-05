//
//  MiddlewareLog.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 17.06.2024.
//

import Foundation
import OSLog

func middlewareLog() -> Middleware<RootState, RootAction> {
    let logger = Logger(subsystem: #function, category: "Action")
    
    func f(_ state: RootState, _ action: RootAction) async -> RootAction? {
        logger.info("action: \(action.description)")
        return nil
    }
    return f
}

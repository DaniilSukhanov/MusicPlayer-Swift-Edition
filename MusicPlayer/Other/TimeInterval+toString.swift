//
//  TimeInterval+toString.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 09.07.2024.
//

import Foundation

extension TimeInterval {
    fileprivate static let formatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    func toString() -> String? {
        return TimeInterval.formatter.string(from: self)
    }
}

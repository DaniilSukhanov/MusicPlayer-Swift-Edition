//
//  AudioQueueManager.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 20.06.2024.
//

import AVFoundation

protocol AudioQueueManagerProtocol {
    associatedtype Audio
    
    var historyAudio: [Audio] { get }
    var currentAudio: Audio? { get }
    var queueAudio: [Audio] { get }
    
    func add(audio: Audio)
    func removeFromQueue(audio: Audio)
    func insertInQueue(audio: Audio, index: Int)
    func nextAudio()
    func previusAudion()
    func clearHistoryAudion()
    func clearQueueAudion()
    func clearCurrentAudio()
    func clearAll()
}

final class AudioQueueManager<Element>: AudioQueueManagerProtocol where Element: Equatable {
    typealias Audio = Element
    
    private(set) var historyAudio = [Audio]()
    private(set) var currentAudio: Audio?
    private(set) var queueAudio = [Audio]()
    
    
    func add(audio: Audio) {
        if currentAudio == nil {
            currentAudio = audio
        } else {
            queueAudio.append(audio)
        }
    }
    
    func removeFromQueue(audio: Audio) {
        if let index = queueAudio.firstIndex(where: { $0 == audio }) {
            queueAudio.remove(at: index)
        }
    }
    
    func insertInQueue(audio: Audio, index: Int) {
        queueAudio.insert(audio, at: index)
    }
    
    func nextAudio() {
        if let currentAudio {
            historyAudio.append(currentAudio)
        }
        
        if let nextAudio = queueAudio.first {
            currentAudio = nextAudio
            removeFromQueue(audio: nextAudio)
        }
    }
    
    func previusAudion() {
        if let currentAudio {
            queueAudio.insert(currentAudio, at: 0)
        }
        if let previusAudion = historyAudio.last {
            currentAudio = previusAudion
            
        }
        
    }
    
    func clearHistoryAudion() {
        historyAudio.removeAll()
    }
    
    func clearQueueAudion() {
        queueAudio.removeAll()
    }
    
    func clearCurrentAudio() {
        currentAudio = nil
    }
    
    func clearAll() {
        clearQueueAudion()
        clearCurrentAudio()
        clearHistoryAudion()
    }
}



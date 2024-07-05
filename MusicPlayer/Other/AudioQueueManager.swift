//
//  AudioQueueManager.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 20.06.2024.
//

import AVFoundation

protocol AudioQueueManagerProtocol {
    var historyAudio: [AVPlayerItem] { get }
    var currentAudio: AVPlayerItem? { get }
    var queueAudio: [AVPlayerItem] { get }
    
    func add(audio: AVPlayerItem)
    func removeFromQueue(audio: AVPlayerItem)
    func insertInQueue(audio: AVPlayerItem, index: Int)
    func nextAudio()
    func previusAudion()
    func clearHistoryAudion()
    func clearQueueAudion()
    func clearCurrentAudio()
}

final class AudioQueueManager: AudioQueueManagerProtocol {
    private(set) var historyAudio = [AVPlayerItem]()
    private(set) var currentAudio: AVPlayerItem?
    private(set) var queueAudio = [AVPlayerItem]()
    
    func add(audio: AVPlayerItem) {
        if currentAudio == nil {
            currentAudio = audio
        } else {
            queueAudio.append(audio)
        }
    }
    
    func removeFromQueue(audio: AVPlayerItem) {
        if let index = queueAudio.firstIndex(where: { $0 == audio }) {
            queueAudio.remove(at: index)
        }
    }
    
    func insertInQueue(audio: AVPlayerItem, index: Int) {
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
}



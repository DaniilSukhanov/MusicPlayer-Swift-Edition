//
//  Data+prettyJSON.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 05.07.2024.
//

import Foundation


extension Data {
    var prettyJSON: String? {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            return String(data: jsonData, encoding: .utf8)
        }
        return nil
    }
}

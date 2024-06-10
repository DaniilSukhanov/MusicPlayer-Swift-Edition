//
//  APIKeyManager.swift
//  MusicPlayer
//
//  Created by Даниил Суханов on 10.06.2024.
//

import Foundation
import Security

protocol APIKeyManagerProtocol {
    static func addAPIKey(key: String, value: String) throws
    static func getAPIKey(key: String) throws -> String
}

final class APIKeyManager: APIKeyManagerProtocol {
    static func addAPIKey(key: String, value: String) throws {
        guard let data = value.data(using: .utf8) else {
            throw APIKeyManagerError.invalidValue
        }
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw APIKeyManagerError.duplicateValue
        }
        guard status == errSecSuccess else {
            throw APIKeyManagerError.unknow(status: status)
        }
    }
    
    static func getAPIKey(key: String) throws -> String {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess, let keyData = item as? Data else {
            throw APIKeyManagerError.unknow(status: status)
        }
        guard let value = String(data: keyData, encoding: .utf8) else {
            throw APIKeyManagerError.invalidValue
        }
        return value
    }
    
    
}

extension APIKeyManager {
    enum APIKeyManagerError: Error {
        case invalidValue
        case duplicateValue
        case unknow(status: OSStatus)
    }
}

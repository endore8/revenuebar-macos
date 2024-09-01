//
//  Codable+Convenience.swift
//  Revenue Bar
//
//  Created by Oleh on 01/09/2024.
//

import Foundation

extension Decodable {
    
    static func with(jsonData data: Data) throws -> Self {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let value = try decoder.decode(Self.self, from: data)
        return value
    }
}

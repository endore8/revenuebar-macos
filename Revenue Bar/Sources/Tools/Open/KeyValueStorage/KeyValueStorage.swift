//
//  KeyValueStorage.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import Foundation
import KeychainAccess

struct KeyValueStorageKey<T>: ExpressibleByStringLiteral {
    let name: String

    init(stringLiteral value: StaticString) {
        self.init(name: value.asString)
    }

    init(name: String) {
        self.name = name
    }
}

protocol KeyValueStorageType: AnyObject {
    subscript(_ key: KeyValueStorageKey<Bool>) -> Bool? { get set }
    subscript(_ key: KeyValueStorageKey<Data>) -> Data? { get set }
    subscript(_ key: KeyValueStorageKey<Double>) -> Double? { get set }
    subscript(_ key: KeyValueStorageKey<Int>) -> Int? { get set }
    subscript(_ key: KeyValueStorageKey<String>) -> String? { get set }
    subscript<T: Codable>(_ key: KeyValueStorageKey<T>) -> T? { get set }
}

extension Keychain: KeyValueStorageType {
    
    subscript(_ key: KeyValueStorageKey<Bool>) -> Bool? {
        get {
            self[key.name]
                .flatMap { Bool($0) }
        }
        set {
            self[key.name] = newValue?.asString
        }
    }
    
    subscript(_ key: KeyValueStorageKey<Data>) -> Data? {
        get {
            self[data: key.name]
                .flatMap { Data($0) }
        }
        set {
            self[data: key.name] = newValue
        }
    }
    
    subscript(_ key: KeyValueStorageKey<Double>) -> Double? {
        get {
            self[key.name]
                .flatMap { Double($0) }
        }
        set {
            self[key.name] = newValue?.asString
        }
    }
    
    subscript(_ key: KeyValueStorageKey<Int>) -> Int? {
        get {
            self[key.name]
                .flatMap { Int($0) }
        }
        set {
            self[key.name] = newValue?.asString
        }
    }
    
    subscript(_ key: KeyValueStorageKey<String>) -> String? {
        get {
            self[key.name]
        }
        set {
            self[key.name] = newValue
        }
    }
    
    subscript<T>(key: KeyValueStorageKey<T>) -> T? where T : Decodable, T : Encodable {
        get {
            self[data: key.name]
                .flatMap { try? JSONDecoder().decode(T.self, from: $0) }
        }
        set {
            self[data: key.name] = try? JSONEncoder().encode(newValue)
        }
    }
}

extension UserDefaults: KeyValueStorageType {
    
    subscript(_ key: KeyValueStorageKey<Bool>) -> Bool? {
        get {
            self.value(forKey: key.name) as? Bool
        }
        set {
            self.setValue(newValue, forKey: key.name)
        }
    }
    
    subscript(_ key: KeyValueStorageKey<Data>) -> Data? {
        get {
            self.value(forKey: key.name) as? Data
        }
        set {
            self.setValue(newValue, forKey: key.name)
        }
    }
    
    subscript(_ key: KeyValueStorageKey<Double>) -> Double? {
        get {
            self.value(forKey: key.name) as? Double
        }
        set {
            self.setValue(newValue, forKey: key.name)
        }
    }
    
    subscript(_ key: KeyValueStorageKey<Int>) -> Int? {
        get {
            self.value(forKey: key.name) as? Int
        }
        set {
            self.setValue(newValue, forKey: key.name)
        }
    }
    
    subscript(_ key: KeyValueStorageKey<String>) -> String? {
        get {
            self.value(forKey: key.name) as? String
        }
        set {
            self.setValue(newValue, forKey: key.name)
        }
    }
    
    subscript<T>(key: KeyValueStorageKey<T>) -> T? where T : Decodable, T : Encodable {
        get {
            (self.value(forKey: key.name) as? Data)
                .flatMap { try? JSONDecoder().decode(T.self, from: $0) }
        }
        set {
            self.setValue(try? JSONEncoder().encode(newValue), forKey: key.name)
        }
    }
}

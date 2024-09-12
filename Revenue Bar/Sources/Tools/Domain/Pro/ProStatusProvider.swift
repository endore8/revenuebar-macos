//
//  ProStatusProvider.swift
//  Revenue Bar
//
//  Created by Oleh on 12/09/2024.
//

protocol ProStatusProviderType {
    var isPro: Bool { get }
}

struct ProStatusProvider: ProStatusProviderType {
    
    let keyValueStorage: KeyValueStorageType
    
    // MARK: - ProStatusProviderType
    
    var isPro: Bool {
        self.keyValueStorage[KeyValueStorageKeys.isPro].orFalse
    }
}

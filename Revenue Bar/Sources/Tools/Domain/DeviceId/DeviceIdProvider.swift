//
//  DeviceIdProvider.swift
//  Revenue Bar
//
//  Created by Oleh on 12/09/2024.
//

import Foundation

struct DeviceIdProvider {
    
    let id: String
    
    init(keyValueStorage: KeyValueStorageType,
         keyValueStorageBackup: KeyValueStorageType) {
        
        let key = KeyValueStorageKeys.deviceId
        
        if let id = keyValueStorage[key] ?? keyValueStorageBackup[key] {
            self.id = id
        }
        else {
            self.id = .uuidString
        }
        
        if keyValueStorage[key] != self.id {
            keyValueStorage[key] = self.id
        }
        if keyValueStorageBackup[key] != self.id {
            keyValueStorageBackup[key] = self.id
        }
    }
}

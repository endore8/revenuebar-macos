//
//  AppLaunchTracking.swift
//  Revenue Bar
//
//  Created by Oleh on 14/09/2024.
//

import Foundation

struct AppLaunchTracking {
    
    init(bundle: Bundle,
         keyValueStorage: KeyValueStorageType,
         keyValueStorageBackup: KeyValueStorageType) {
        
        let currentLaunchNumber = keyValueStorage[KeyValueStorageKeys.currentLaunchNumber] ?? keyValueStorageBackup[KeyValueStorageKeys.currentLaunchNumber]
        
        if let currentLaunchNumber {
            self.currentLaunchNumber = currentLaunchNumber.incremented
        }
        else {
            self.currentLaunchNumber = .one
        }
        
        let firstLaunchAppVersion = keyValueStorage[KeyValueStorageKeys.firstLaunchAppVersion] ?? keyValueStorageBackup[KeyValueStorageKeys.firstLaunchAppVersion]
        
        if let firstLaunchAppVersion {
            self.firstLaunchAppVersion = firstLaunchAppVersion
        }
        else {
            self.firstLaunchAppVersion = bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-"
        }
        
        let firstLaunchTimestamp = keyValueStorage[KeyValueStorageKeys.firstLaunchTimestamp] ?? keyValueStorageBackup[KeyValueStorageKeys.firstLaunchTimestamp]
        
        if let firstLaunchTimestamp {
            self.firstLaunchTimestamp = firstLaunchTimestamp
        }
        else {
            self.firstLaunchTimestamp = Date.now.timeIntervalSince1970
        }
        
        if keyValueStorage[KeyValueStorageKeys.firstLaunchAppVersion] != self.firstLaunchAppVersion {
            keyValueStorage[KeyValueStorageKeys.firstLaunchAppVersion] = self.firstLaunchAppVersion
        }
        if keyValueStorageBackup[KeyValueStorageKeys.firstLaunchAppVersion] != self.firstLaunchAppVersion {
            keyValueStorageBackup[KeyValueStorageKeys.firstLaunchAppVersion] = self.firstLaunchAppVersion
        }
        
        if keyValueStorage[KeyValueStorageKeys.firstLaunchTimestamp] != self.firstLaunchTimestamp {
            keyValueStorage[KeyValueStorageKeys.firstLaunchTimestamp] = self.firstLaunchTimestamp
        }
        if keyValueStorageBackup[KeyValueStorageKeys.firstLaunchTimestamp] != self.firstLaunchTimestamp {
            keyValueStorageBackup[KeyValueStorageKeys.firstLaunchTimestamp] = self.firstLaunchTimestamp
        }
        
        keyValueStorage[KeyValueStorageKeys.currentLaunchNumber] = self.currentLaunchNumber
        keyValueStorageBackup[KeyValueStorageKeys.currentLaunchNumber] = self.currentLaunchNumber
    }
    
    // MARK: - AppLaunchTrackingType
    
    let currentLaunchNumber: Int
    let firstLaunchTimestamp: TimeInterval
    let firstLaunchAppVersion: String
}

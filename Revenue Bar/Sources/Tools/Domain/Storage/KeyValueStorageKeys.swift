//
//  KeyValueStorageKeys.swift
//  Revenue Bar
//
//  Created by Oleh on 01/09/2024.
//

import Foundation

enum KeyValueStorageKeys {
    
    static let deviceId: KeyValueStorageKey<DeviceId> = "device-id"
    static let isPro: KeyValueStorageKey<Bool> = "is-pro"
    static let projects: KeyValueStorageKey<[Project]> = "projects"
    
    static let currentLaunchNumber: KeyValueStorageKey<Int> = "current-launch-number"
    static let firstLaunchAppVersion: KeyValueStorageKey<String> = "first-launch-app-version"
    static let firstLaunchTimestamp: KeyValueStorageKey<TimeInterval> = "first-launch-timestamp"
}

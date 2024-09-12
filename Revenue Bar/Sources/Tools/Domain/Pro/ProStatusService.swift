//
//  ProStatusService.swift
//  Revenue Bar
//
//  Created by Oleh on 12/09/2024.
//

import Foundation
import RevenueCat

protocol ProStatusServiceType {
    func start()
}

struct ProStatusRevenueCatService: ProStatusServiceType {
    
    init(keyValueStorage: KeyValueStorageType,
         purchases: Purchases) {
        
        self.delegate = ProStatusPurchasesDelegate(
            keyValueStorage: keyValueStorage
        )
        self.purchases = purchases
    }
    
    // MARK: - ProStatusServiceType
    
    func start() {
        self.purchases.delegate = self.delegate
    }
    
    // MARK: - Private
    
    private let delegate: ProStatusPurchasesDelegate
    private let purchases: Purchases
}

private final class ProStatusPurchasesDelegate: NSObject, PurchasesDelegate {
    
    let keyValueStorage: KeyValueStorageType

    init(keyValueStorage: KeyValueStorageType) {
        self.keyValueStorage = keyValueStorage
    }
    
    func purchases(_ purchases: Purchases, receivedUpdated customerInfo: CustomerInfo) {
        let isPro = customerInfo.isPro
        let lastIsPro = self.keyValueStorage[KeyValueStorageKeys.isPro]
        
        if isPro == lastIsPro {
            return
        }
        
        self.keyValueStorage[KeyValueStorageKeys.isPro] = isPro
    }
}

extension CustomerInfo {
    
    private enum Constants {
        static let proEntitlement: String = "pro"
    }
    
    fileprivate var isPro: Bool {
        self.entitlements[Constants.proEntitlement]?.isActive == true
    }
}

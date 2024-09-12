//
//  ProPurchaseProvider.swift
//  Revenue Bar
//
//  Created by Oleh on 12/09/2024.
//

import Foundation
import RevenueCat

struct ProPurchaseProduct: Hashable {
    let package: Package
}

enum ProPurchaseProviderError: Error {
    case noCurrentOffering
    case noProducts
}

protocol ProPurchaseProviderType {
    func products(_ completion: @escaping TypeResultClosure<[ProPurchaseProduct]>)
    func purchase(product: ProPurchaseProduct, _ completion: @escaping VoidClosure)
    func restore(_ completion: @escaping VoidClosure)
}

struct ProPurchaseRevenueCatProvider: ProPurchaseProviderType {
    
    let keyValueStorage: KeyValueStorageType
    let purchases: Purchases
    
    // MARK: - ProPurchaseProviderType
    
    func products(_ completion: @escaping TypeResultClosure<[ProPurchaseProduct]>) {
        self.purchases.getOfferings { offerings, error in
            guard
                let offering = offerings?.current
            else {
                completion(.failure(ProPurchaseProviderError.noCurrentOffering))
                return
            }
            
            let products = offering.availablePackages.map { ProPurchaseProduct(package: $0) }
            if products.isEmpty {
                completion(.failure(ProPurchaseProviderError.noProducts))
                return
            }
            
            completion(.success(products))
        }
    }
    
    func purchase(product: ProPurchaseProduct, _ completion: @escaping VoidClosure) {
        self.purchases.purchase(package: product.package) { _, _, _, _ in
            completion()
        }
    }
    
    func restore(_ completion: @escaping VoidClosure) {
        self.purchases.restorePurchases { _, _ in
            completion()
        }
    }
}

extension Array where Element == Package {
    
    fileprivate var products: [ProPurchaseProduct] {
        self.map {
            ProPurchaseProduct(
                package: $0
            )
        }
    }
}

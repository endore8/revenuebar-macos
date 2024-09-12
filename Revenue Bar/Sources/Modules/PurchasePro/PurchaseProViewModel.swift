//
//  PurchaseProViewModel.swift
//  Revenue Bar
//
//  Created by Oleh on 12/09/2024.
//

import Foundation

@Observable
final class PurchaseProViewModel {
    
    let proPurchaseProvider: ProPurchaseProviderType
    
    init(proPurchaseProvider: ProPurchaseProviderType) {
        self.proPurchaseProvider = proPurchaseProvider
    }
    
    private(set) var isLoading: Bool = false
    
    private(set) var products: [ProPurchaseProduct]?
    
    private(set) var loadingError: Error? = nil
    
    private(set) var purchasingProductId: String? = nil
    
    func load() {
        self.proPurchaseProvider.products { [weak self] result in
            switch result {
            case .success(let products):
                self?.products = products
                self?.isLoading = false
                self?.loadingError = nil
            case .failure(let error):
                self?.products = nil
                self?.isLoading = false
                self?.loadingError = error
            }
        }
    }
    
    func purchase(product: ProPurchaseProduct) {
        guard
            self.purchasingProductId.isNil
        else { return }
        self.purchasingProductId = product.id
        self.proPurchaseProvider.purchase(product: product) { [weak self] in
            self?.purchasingProductId = nil
        }
    }
}

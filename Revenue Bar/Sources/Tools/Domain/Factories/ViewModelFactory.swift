//
//  ViewModelFactory.swift
//  Revenue Bar
//
//  Created by Oleh on 01/09/2024.
//

import Foundation

protocol ViewModelFactoryType {
    func makeAuthViewModel() -> AuthViewModel
    func makeDashboardViewModel() -> DashboardViewModel
    func makePreferencesViewModel() -> PreferencesViewModel
    func makePurchaseViewModel() -> PurchaseProViewModel
}

struct ViewModelFactory: ViewModelFactoryType {
    
    let openAtLoginHandler: OpenAtLoginHandler
    let projectFetcher: ProjectFetcherType
    let projectFetcherService: ProjectFetcherServiceType
    let projectMetricsStorage: ProjectMetricsStorageType
    let projectsStorage: ProjectsStorageType
    
    // MARK: - ViewModelFactoryType
    
    func makeAuthViewModel() -> AuthViewModel {
        AuthViewModel(
            projectFetcher: self.projectFetcher,
            projectMetricsStorage: self.projectMetricsStorage,
            projectsStorage: self.projectsStorage
        )
    }
    
    func makeDashboardViewModel() -> DashboardViewModel {
        DashboardViewModel(
            projectFetcherService: self.projectFetcherService,
            projectMetricsStorage: self.projectMetricsStorage,
            projectsStorage: self.projectsStorage
        )
    }
    
    func makePreferencesViewModel() -> PreferencesViewModel {
        PreferencesViewModel(
            openAtLoginHandler: self.openAtLoginHandler,
            projectMetricsStorage: self.projectMetricsStorage,
            projectsStorage: self.projectsStorage
        )
    }
    
    func makePurchaseViewModel() -> PurchaseProViewModel {
        PurchaseProViewModel()
    }
}

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
}

struct ViewModelFactory: ViewModelFactoryType {
    
    let projectFetcher: ProjectFetcherType
    let projectsStorage: ProjectsStorageType
    
    // MARK: - ViewModelFactoryType
    
    func makeAuthViewModel() -> AuthViewModel {
        AuthViewModel(
            projectFetcher: self.projectFetcher,
            projectsStorage: self.projectsStorage
        )
    }
    
    func makeDashboardViewModel() -> DashboardViewModel {
        DashboardViewModel()
    }
    
    func makePreferencesViewModel() -> PreferencesViewModel {
        PreferencesViewModel()
    }
}

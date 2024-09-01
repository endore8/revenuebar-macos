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
    
    // MARK: - ViewModelFactoryType
    
    func makeAuthViewModel() -> AuthViewModel {
        AuthViewModel()
    }
    
    func makeDashboardViewModel() -> DashboardViewModel {
        DashboardViewModel()
    }
    
    func makePreferencesViewModel() -> PreferencesViewModel {
        PreferencesViewModel()
    }
}

//
//  MenuPopoverNavigationCoordinator.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import AppKit
import Foundation

protocol MenuPopoverNavigationCoordinatorType {
    var view: NSView { get }
}

final class MenuPopoverNavigationCoordinator: MenuPopoverNavigationCoordinatorType {
    
    let viewModelFactory: ViewModelFactoryType
    
    init(viewModelFactory: ViewModelFactoryType) {
        self.viewModelFactory = viewModelFactory
        
        self.navigationView = MenuPopoverView()
        
        self.showInitial()
    }
    
    // MARK: - MenuPopoverNavigationCoordinatorType
    
    var view: NSView {
        self.navigationView
    }
    
    // MARK: - Private
    
    private let navigationView: MenuPopoverView
    
    private func showInitial() {
        // TODO:
        self.showAuth()
    }
    
    private func showAuth() {
        let viewModel = AuthViewModel()
        let view = AuthView(
            viewModel: viewModel
        )
        self.navigationView.show(
            view: view
        )
    }
    
    private func showDashboard() {
        let viewModel = DashboardViewModel()
        let view = DashboardView(
            viewModel: viewModel
        )
        self.navigationView.show(
            view: view
        )
    }
    
    private func showPreferences() {
        let viewModel = PreferencesViewModel()
        let view = PreferencesView(
            viewModel: viewModel
        )
        self.navigationView.show(
            view: view
        )
    }
}

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
        let viewModel = self.viewModelFactory.makeAuthViewModel()
        let view = AuthView(
            onDone: self.showDashboard
        )
        .environment(viewModel)
        self.navigationView.show(
            view: view
        )
    }
    
    private func showDashboard() {
        let viewModel = DashboardViewModel()
        let view = DashboardView()
            .environment(viewModel)
        self.navigationView.show(
            view: view
        )
    }
    
    private func showPreferences() {
        let viewModel = PreferencesViewModel()
        let view = PreferencesView()
            .environment(viewModel)
        self.navigationView.show(
            view: view
        )
    }
}

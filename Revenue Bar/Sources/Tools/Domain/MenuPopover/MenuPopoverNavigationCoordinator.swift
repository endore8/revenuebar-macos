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
    
    let projectsStorage: ProjectsStorageType
    let viewModelFactory: ViewModelFactoryType
    let onDismiss: VoidClosure

    init(projectsStorage: ProjectsStorageType,
         viewModelFactory: ViewModelFactoryType,
         onDismiss: @escaping VoidClosure) {
        
        self.projectsStorage = projectsStorage
        self.viewModelFactory = viewModelFactory
        self.onDismiss = onDismiss
        
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
        if self.projectsStorage.projects.isNotNil {
            self.showDashboard()
        }
        else {
            self.showAuth()
        }
    }
    
    private func showAuth() {
        let viewModel = self.viewModelFactory.makeAuthViewModel()
        let view = AuthView(
            onDismiss: self.dismissAuth,
            onDone: self.showDashboard
        )
        .environment(viewModel)
        self.navigationView.show(
            view: view
        )
    }
    
    private func dismissAuth() {
        if self.projectsStorage.projects.isNotNil {
            self.showDashboard()
        }
        else {
            self.onDismiss()
        }
    }
    
    private func showDashboard() {
        let viewModel = self.viewModelFactory.makeDashboardViewModel()
        let view = DashboardView(
            onShowPreferences: self.showPreferences
        )
        .environment(viewModel)
        self.navigationView.show(
            view: view
        )
    }
    
    private func showPreferences() {
        let viewModel = self.viewModelFactory.makePreferencesViewModel()
        let view = PreferencesView(
            onAddProject: self.showAuth,
            onDismiss: self.showDashboard
        )
        .environment(viewModel)
        self.navigationView.show(
            view: view
        )
    }
}

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
    let proStatusProvider: ProStatusProviderType
    let viewModelFactory: ViewModelFactoryType
    let onDismiss: VoidClosure

    init(projectsStorage: ProjectsStorageType,
         proStatusProvider: ProStatusProviderType,
         viewModelFactory: ViewModelFactoryType,
         onDismiss: @escaping VoidClosure) {
        
        self.projectsStorage = projectsStorage
        self.proStatusProvider = proStatusProvider
        self.viewModelFactory = viewModelFactory
        self.onDismiss = onDismiss
        
        self.navigationView = MenuPopoverView()
        
        self.projectsStorage.clearDemoProjects()
        
        self.showInitial()
        
        self.projectsStorage
            .onChange
            .sink { [weak self] in
                self?.showAuthIfNeeded()
            }
            .store(in: &self.notifierContainer)
    }
    
    // MARK: - MenuPopoverNavigationCoordinatorType
    
    var view: NSView {
        self.navigationView
    }
    
    // MARK: - Private
    
    private let navigationView: MenuPopoverView
    
    private var notifierContainer: NotifierContainer?
    
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
    
    private func showAuthIfNeeded() {
        if self.projectsStorage.projects.isNil {
            self.showAuth()
        }
    }
    
    private func showAuthOrPro() {
        if self.proStatusProvider.isPro {
            self.showAuth()
        }
        else {
            self.showPurchasePro()
        }
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
            onAddProject: self.showAuthOrPro,
            onDismiss: self.showDashboard
        )
        .environment(viewModel)
        self.navigationView.show(
            view: view
        )
    }
    
    private func showPurchasePro() {
        let viewModel = self.viewModelFactory.makePurchaseViewModel()
        let view = PurchaseProView(
            onDone: self.showDashboard,
            onDismiss: self.showPreferences
        )
        .environment(viewModel)
        self.navigationView.show(
            view: view
        )
    }
}

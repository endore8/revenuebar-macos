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
    
    init() {
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
        let view = AuthView()
        self.navigationView.show(
            view: view
        )
    }
    
    private func showDashboard() {
        let view = DashboardView()
        self.navigationView.show(
            view: view
        )
    }
    
    private func showPreferences() {
        let view = PreferencesView()
        self.navigationView.show(
            view: view
        )
    }
}

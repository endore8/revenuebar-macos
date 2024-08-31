//
//  MenuPopoverNavigationCoordinator.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import AppKit
import Foundation

protocol MenuPopoverNavigationCoordinatorType {
    var window: MenuPopoverWindow { get }
}

final class MenuPopoverNavigationCoordinator: MenuPopoverNavigationCoordinatorType {
    
    init() {
        self.window = MenuPopoverWindow()
    }
    
    // MARK: - MenuPopoverNavigationCoordinatorType
    
    let window: MenuPopoverWindow
}

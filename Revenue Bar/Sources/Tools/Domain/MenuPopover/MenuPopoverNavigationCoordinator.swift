//
//  MenuPopoverNavigationCoordinator.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import AppKit
import Foundation

protocol MenuPopoverNavigationCoordinatorType {
    var view: MenuPopoverView { get }
}

final class MenuPopoverNavigationCoordinator: MenuPopoverNavigationCoordinatorType {
    
    init() {
        self.view = MenuPopoverView()
    }
    
    // MARK: - MenuPopoverNavigationCoordinatorType
    
    let view: MenuPopoverView
}

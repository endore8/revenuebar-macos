//
//  AppDelegate.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import Cocoa

final class AppDelegate: NSObject, NSApplicationDelegate {
    
    // MARK: - NSApplicationDelegate
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        let dependencies = Dependencies()
        
        dependencies.menuBarController.onAction = { [weak self] in
            self?.presentMenuPopover(relativeTo: $0)
        }
        
        dependencies.menuBarController.setUp()
        
        self.dependencies = dependencies
    }
    
    // MARK: - Private

    private var dependencies: Dependencies?
    
    private func presentMenuPopover(relativeTo view: NSView) {
        guard
            let dependencies
        else { return }
        
        dependencies.menuPopoverController.present(
            relativeTo: view
        )
    }
}

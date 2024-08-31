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
        
        dependencies.menuBarController.onAction = {
        }
        
        dependencies.menuBarController.setUp()
        
        self.dependencies = dependencies
    }
    
    // MARK: - Private

    private var dependencies: Dependencies?
}

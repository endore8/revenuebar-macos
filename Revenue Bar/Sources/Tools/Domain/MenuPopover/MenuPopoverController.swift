//
//  MenuPopoverController.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import AppKit
import Foundation

protocol MenuPopoverControllerType {
    func present(relativeTo view: NSView)
}

final class MenuPopoverController: MenuPopoverControllerType {
    
    // MARK: - MenuPopoverControllerType
    
    func present(relativeTo view: NSView) {
        
    }
    
    // MARK: - Private
    
    private func hide() {
    }
}

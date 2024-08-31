//
//  MenuPopoverWindow.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import AppKit

final class MenuPopoverWindow: NSWindow {
    
    init() {
        super.init(
            contentRect: .zero,
            styleMask: [],
            backing: .buffered,
            defer: false
        )
        
        self.backgroundColor = NSColor(
            calibratedWhite: .one,
            alpha: .one // TODO: Should be zero instead
        )
        self.hasShadow = true
        self.isOpaque = false
        self.level = .statusBar
        self.styleMask = []
        self.titleVisibility = .hidden
    }
    
    override var canBecomeKey: Bool {
        true
    }
}

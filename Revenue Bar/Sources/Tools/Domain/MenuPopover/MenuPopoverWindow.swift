//
//  MenuPopoverWindow.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import AppKit

final class MenuPopoverWindow: NSWindow {
    
    init(contentView: NSView) {
        super.init(
            contentRect: .zero,
            styleMask: [],
            backing: .buffered,
            defer: false
        )
        
        self.backgroundColor = NSColor(
            calibratedWhite: .one,
            alpha: .zero
        )
        self.contentView = contentView
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

//
//  MenuPopoverView.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import AppKit

final class MenuPopoverView: NSView {
    
    init() {
        super.init(frame: .zero)
        
        self.wantsLayer = true
        
        self.layer?.backgroundColor = NSColor.blue.cgColor
        self.layer?.cornerRadius = 10
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  BaseNSView.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import AppKit

class BaseNSView: NSView {
    
    init() {
        super.init(frame: .zero)
        
        // Fixes sizing issue
        self.wantsLayer = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

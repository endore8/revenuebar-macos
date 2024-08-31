//
//  MenuPopoverView.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import AppKit

final class MenuPopoverView: BaseNSView {
    
    override init() {
        super.init()
        
        self.layer?.backgroundColor = NSColor.blue.cgColor
        self.layer?.cornerRadius = 10
    }
}

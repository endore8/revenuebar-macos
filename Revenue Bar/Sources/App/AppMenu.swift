//
//  AppMenu.swift
//  Revenue Bar
//
//  Created by Oleh on 04/09/2024.
//

import Cocoa

final class AppMenu: NSMenu {
    
    override init(title: String) {
        super.init(title: title)
        
        let editMenuSubmenu = NSMenu(title: "edit")
        editMenuSubmenu.items = [
            NSMenuItem(
                title: "Cut",
                action: #selector(NSText.cut(_:)),
                keyEquivalent: "x"
            ),
            NSMenuItem(
                title: "Copy",
                action: #selector(NSText.copy(_:)),
                keyEquivalent: "c"
            ),
            NSMenuItem(
                title: "Paste",
                action: #selector(NSText.paste(_:)),
                keyEquivalent: "v"
            ),
            NSMenuItem(
                title: "Select All",
                action: #selector(NSText.selectAll(_:)),
                keyEquivalent: "a"
            )
        ]
        
        let editMenu = NSMenuItem()
        editMenu.submenu = editMenuSubmenu
        
        self.items = [editMenu]
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}

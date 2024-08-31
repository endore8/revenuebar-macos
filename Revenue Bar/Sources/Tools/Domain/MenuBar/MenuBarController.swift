//
//  MenuBarController.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import AppKit
import Foundation
import SnapKit

protocol MenuBarControllerType: AnyObject {
    var onAction: VoidClosure? { get set }
    func setUp()
}

final class MenuBarController: MenuBarControllerType {
    
    // MARK: - MenuBarControllerType
    
    var onAction: VoidClosure? = nil
    
    func setUp() {
        
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.blue.cgColor
        
        self.systemStatusItem.button?.addSubview(view) {
            $0.leading.trailing.equalToSuperview()
            $0.top.greaterThanOrEqualToSuperview().priority(.low)
            $0.bottom.lessThanOrEqualToSuperview().priority(.low)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Private
    
    private lazy var systemStatusItem: NSStatusItem = {
        let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem.button?.onAction = { [weak self] in
            self?.onAction?()
        }
        return statusItem
    }()
}

extension NSStatusItem {
    
    fileprivate func hide() {
        self.button?.subviews.forEach { $0.removeFromSuperview() }
        self.button?.frame = .zero
    }
}

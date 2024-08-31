//
//  NSButton+Convenience.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import AppKit

extension NSButton {
    
    var onAction: VoidClosure? {
        get { self.lazyClosureHandler.closure }
        set {
            self.lazyClosureHandler.closure = newValue
            self.target = self.lazyClosureHandler
            self.action = #selector(ButtonClosureHandler.handleAction)
        }
    }
}

private final class ButtonClosureHandler {
    
    var closure: VoidClosure?
    
    @objc
    fileprivate func handleAction() {
        self.closure?()
    }
}

private var AssociatedObjectButtonClosureHandler: UInt8 = 0

extension NSButton {
    
    private var closureHandler: ButtonClosureHandler? {
        get {
            objc_getAssociatedObject(self, &AssociatedObjectButtonClosureHandler) as? ButtonClosureHandler
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectButtonClosureHandler, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var lazyClosureHandler: ButtonClosureHandler {
        if let stored = self.closureHandler {
            return stored
        }
        let closureHandler = ButtonClosureHandler()
        self.closureHandler = closureHandler
        return closureHandler
    }
}

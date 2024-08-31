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
        
        guard
            let targetScreen = view.window?.screen,
            let targetFrame = view.window?.convertToScreen(view.bounds)
        else {
            self.hide()
            return
        }
        
        if self.isShown && self.targetScreen == targetScreen {
            self.hide()
            return
        }
        
        if self.isShown {
            self.hide()
        }
        
        let navigationCoordinator = MenuPopoverNavigationCoordinator()
        let window = navigationCoordinator.window
        let windowController = NSWindowController()
        
        self.navigationCoordinator = navigationCoordinator
        
        self.targetFrame = targetFrame
        self.targetScreen = targetScreen
        
        self.windowController = windowController
        
        self.updateFrame(window: window)
        
        windowController.window = window
        windowController.showWindow(nil)
        
        
        self.eventMonitor.start()
    }
    
    // MARK: - MenuPopoverVisibilityControllerType
    
    func hide() {
        self.eventMonitor.stop()
        
        self.navigationCoordinator = nil
        
        self.targetFrame = nil
        self.targetScreen = nil
        
        self.windowController?.close()
        self.windowController = nil
    }
    
    // MARK: - Private
    
    private lazy var eventMonitor: EventMonitor = .init(mask: [.leftMouseUp, .rightMouseUp]) { event in
        if event?.window != self.windowController?.window {
            self.hide()
        }
    }
    
    private var isShown: Bool {
        self.windowController.isNotNil
    }
    
    private var navigationCoordinator: MenuPopoverNavigationCoordinatorType? = nil
    
    private var targetFrame: CGRect? = nil
    private weak var targetScreen: NSScreen? = nil
    
    private var windowController: NSWindowController? = nil
    
    private func updateWindowFrame() {
        guard
            let window = self.windowController?.window
        else { return }
        
        self.updateFrame(window: window)
    }
    
    private func updateFrame(window: NSWindow) {
            
        guard
            let targetFrame,
            let targetScreen
        else { return }
        
        let screenFrame = targetScreen.visibleFrame
        let width: CGFloat = 400
        let height: CGFloat = 500
        let x = min(
            targetFrame.center.x - width / 2,
            screenFrame.maxX - width
        )
        let y = screenFrame.maxY - height
                
        let origin = NSPoint(
            x: x,
            y: y
        )
        let size = NSSize(
            width: width,
            height: height
        )
        let frame = NSRect(
            origin: origin,
            size: size
        )
        
        window.setFrame(
            frame,
            display: true
        )
    }
}

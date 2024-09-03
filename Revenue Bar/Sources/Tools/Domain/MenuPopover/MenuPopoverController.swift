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
    
    let projectsStorage: ProjectsStorageType
    let viewModelFactory: ViewModelFactoryType
    
    init(projectsStorage: ProjectsStorageType,
         viewModelFactory: ViewModelFactoryType) {
        
        self.projectsStorage = projectsStorage
        self.viewModelFactory = viewModelFactory
    }
    
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
        
        let eventMonitor = EventMonitor(mask: [.leftMouseUp, .rightMouseUp]) { [weak self] event in
            if event?.window != self?.windowController?.window {
                self?.hide()
            }
        }
        let navigationCoordinator = MenuPopoverNavigationCoordinator(
            projectsStorage: self.projectsStorage,
            viewModelFactory: self.viewModelFactory
        )
        let window = MenuPopoverWindow(
            contentView: navigationCoordinator.view
        )
        let windowController = NSWindowController(
            window: window
        )
        
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
        
        self.eventMonitor = eventMonitor
        self.navigationCoordinator = navigationCoordinator
        self.targetScreen = targetScreen
        self.windowController = windowController
        
        self.eventMonitor?.start()
        self.windowController?.showWindow(nil)
    }
    
    // MARK: - MenuPopoverVisibilityControllerType
    
    func hide() {
        self.windowController?.close()
        
        self.eventMonitor = nil
        self.navigationCoordinator = nil
        self.targetScreen = nil
        self.windowController = nil
    }
    
    // MARK: - Private
    
    private var isShown: Bool {
        self.windowController.isNotNil
    }
    
    private var eventMonitor: EventMonitor? = nil
    private var navigationCoordinator: MenuPopoverNavigationCoordinatorType? = nil
    private weak var targetScreen: NSScreen? = nil
    private var windowController: NSWindowController? = nil
}

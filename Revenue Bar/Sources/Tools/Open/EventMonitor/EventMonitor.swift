//
//  EventMonitor.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import Cocoa

final class EventMonitor {
    
    let mask: NSEvent.EventTypeMask
    let handler: TypeClosure<NSEvent?>
    
    init(mask: NSEvent.EventTypeMask, 
         handler: @escaping TypeClosure<NSEvent?>) {
        
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        self.stop()
    }
    
    func start() {
        self.globalMonitor = NSEvent
            .addGlobalMonitorForEvents(matching: self.mask) { [weak self] event in
                self?.handler(event)
            }
        self.localMonitor = NSEvent
            .addLocalMonitorForEvents(matching: self.mask) { [weak self] event in
                self?.handler(event)
                return event
            }
    }
    
    func stop() {
        self.globalMonitor.map {
            NSEvent.removeMonitor($0)
        }
        self.globalMonitor = nil
        
        self.localMonitor.map {
            NSEvent.removeMonitor($0)
        }
        self.localMonitor = nil
    }
    
    // MARK: - Private
    
    private var globalMonitor: Any? = nil
    private var localMonitor: Any? = nil
}

//
//  MenuPopoverView.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import AppKit
import SwiftUI

final class MenuPopoverView: BaseNSView {
    
    override init() {
        super.init()
        
        self.addSubview(self.containerView) {
            $0.top.leading.trailing.equalToSuperview()
        }
    }
    
    override func updateLayer() {
        super.updateLayer()
        
        self.containerView.layer?.backgroundColor = NSColor.menupopoverBackground.cgColor
    }
    
    func show<Content>(view: Content) where Content: View {
        self.show(
            view: NSHostingView(
                rootView: view
            )
        )
    }
    
    // MARK: - Private
    
    private let containerView: BaseNSView = .init().configure {
        $0.layer?.cornerRadius = .CornerRadius.eight
    }
    
    private func show(view: NSView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        if self.containerView.subviews.isEmpty {
            self.containerView.addSubview(view) {
                $0.edges.equalToSuperview()
            }
        }
        else {
            NSAnimationContext.runAnimationGroup { context in
                context.allowsImplicitAnimation = true
                context.duration = 0.2
                self.containerView.subviews.forEach {
                    $0.removeFromSuperview()
                }
                self.containerView.addSubview(view) {
                    $0.edges.equalToSuperview()
                }
                self.containerView.layoutSubtreeIfNeeded()
            }
        }
    }
}

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
        
        self.addSubview(self.backgroundView)
        self.addSubview(self.containerView)
    }
    
    override func updateConstraints() {
        
        self.backgroundView.snp.updateConstraints {
            $0.edges.equalTo(self.containerView)
        }
        
        self.containerView.snp.updateConstraints {
           $0.top.leading.trailing.equalToSuperview()
        }
        
        super.updateConstraints()
    }
    
    func show<Content>(view: Content) where Content: View {
        self.show(
            view: NSHostingView(
                rootView: view
            )
        )
    }
    
    // MARK: - Private
    
    private let backgroundView: NSVisualEffectView = .init().configure {
        $0.state = .active
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.wantsLayer = true
        $0.layer?.cornerRadius = .CornerRadius.ten
    }
    
    private let containerView: BaseNSView = .init()
    
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

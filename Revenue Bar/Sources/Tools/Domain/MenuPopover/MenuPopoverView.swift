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
        
        self.layer?.cornerRadius = .CornerRadius.ten
    }
    
    func show<Content>(view: Content) where Content: View {
        self.show(
            view: NSHostingView(
                rootView: ZStack {
                    Color.clear // TODO: Maybe can be removed when content views are resizible.
                    view
                }
            )
        )
    }
    
    // MARK: - Private
    
    private var view: NSView?
    
    private func show(view: NSView) {
        self.view?.removeFromSuperview()
        self.addSubview(view) {
            $0.top.leading.trailing.equalToSuperview()
        }
        self.view = view
    }
}

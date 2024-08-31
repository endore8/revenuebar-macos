//
//  NSView+Convenience.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import AppKit
import SnapKit

protocol NSViewConfigure: NSObjectProtocol {}

extension NSViewConfigure {
    
    @discardableResult
    func configure(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSView: NSViewConfigure {}

extension NSView {
    
    func addSubview(_ view: NSView, makeConstraints: (ConstraintMaker) -> Void) {
        self.addSubview(view)
        view.snp.makeConstraints(makeConstraints)
    }
}

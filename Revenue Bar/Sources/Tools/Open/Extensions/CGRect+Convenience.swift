//
//  CGRect+Convenience.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import Foundation

extension CGRect {
    
    var center: CGPoint {
        CGPoint(
            x: self.midX,
            y: self.midY
        )
    }
}

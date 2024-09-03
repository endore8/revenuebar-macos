//
//  Opacity.swift
//  Revenue Bar
//
//  Created by Oleh on 03/09/2024.
//

import Foundation

extension CGFloat {
    
    enum Opacity {
        /// 1.0
        static let opaque: CGFloat = 1.0
        /// 0.8
        static let dimmed: CGFloat = 0.8
        /// 0.4
        static let mild: CGFloat = 0.4
        /// 0.2
        static let pastel: CGFloat = 0.2
        /// 0.02
        static let pale: CGFloat = 0.02
        /// 0
        static let transparent: CGFloat = 0
        
        /// 0.4
        static let disabled: CGFloat = 0.4
        
        /// 0.05
        static let separator: CGFloat = 0.05
    }
}

extension Double {
    typealias Opacity = CGFloat.Opacity
}

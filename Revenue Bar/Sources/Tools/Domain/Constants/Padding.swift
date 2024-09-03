//
//  Padding.swift
//  Revenue Bar
//
//  Created by Oleh on 03/09/2024.
//

import Foundation

extension CGFloat {
    
    enum Padding {
        /// 0
        static let none: CGFloat = 0
        /// 1
        static let minimum: CGFloat = 1
        /// 2
        static let small: CGFloat = 2
        /// 4
        static let compact: CGFloat = 4
        /// 8
        static let inner: CGFloat = 8
        /// 12
        static let middle: CGFloat = 12
        /// 16
        static let outer: CGFloat = 16
        /// 24
        static let outerExtended: CGFloat = 24
        /// 32
        static let exterior: CGFloat = 32
        /// 48
        static let spacious: CGFloat = 48
        /// 12
        static let button: CGFloat = .Padding.middle
    }
}

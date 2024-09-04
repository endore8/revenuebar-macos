//
//  Collection+Convenience.swift
//  Revenue Bar
//
//  Created by Oleh on 04/09/2024.
//

import Foundation

extension Collection {
    
    var asArray: [Element] {
        Array(self)
    }
}

extension Collection where Element: Hashable {
    
    var asSet: Set<Element> {
        Set(self)
    }
}

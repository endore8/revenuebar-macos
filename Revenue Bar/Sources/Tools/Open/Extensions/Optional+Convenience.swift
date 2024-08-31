//
//  Optional+Convenience.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import Foundation

extension Optional {
    
    var isNil: Bool {
        self == nil
    }
    
    var isNotNil: Bool {
        self != nil
    }
}

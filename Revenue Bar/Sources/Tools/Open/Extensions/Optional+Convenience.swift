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

extension Optional where Wrapped == Bool {

    var not: Bool? {
        guard
            let value = self
        else {
            return nil
        }
        return value.not
    }

    var orFalse: Bool {
        guard
            let value = self
        else {
            return false
        }
        return value
    }

    var orTrue: Bool {
        guard
            let value = self
        else {
            return true
        }
        return value
    }
}

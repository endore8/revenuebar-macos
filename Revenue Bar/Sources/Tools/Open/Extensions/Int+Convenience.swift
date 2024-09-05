//
//  Int+Convenience.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import Foundation

extension Int {
    
    var asString: String {
        "\(self)"
    }
    
    var decimalFormatted: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: self))
        return result ?? self.asString
    }
}

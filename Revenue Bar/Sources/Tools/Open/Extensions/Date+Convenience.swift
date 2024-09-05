//
//  Date+Convenience.swift
//  Revenue Bar
//
//  Created by Oleh on 05/09/2024.
//

import Foundation

extension Date {
    
    var relativeToNowFormatted: String {
        let now = Date.now
        if now.timeIntervalSince(self) < .one {
            return "Just now"
        }
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        let result = formatter.localizedString(for: self, relativeTo: .now)
        return result
    }
}

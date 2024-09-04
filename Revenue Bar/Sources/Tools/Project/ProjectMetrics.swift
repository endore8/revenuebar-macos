//
//  ProjectMetrics.swift
//  Revenue Bar
//
//  Created by Oleh on 01/09/2024.
//

import Foundation

struct ProjectMetrics {
    let metrics: [Metric]
    
    struct Metric: Identifiable {
        let id: String
        let name: String
        let description: String
        let value: Int
        let updatedAt: Date?
    }
}

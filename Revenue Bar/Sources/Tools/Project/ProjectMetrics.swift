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

extension ProjectMetrics {
    
    static var demo: ProjectMetrics {
        ProjectMetrics(
            metrics: [
                ProjectMetrics.Metric(
                    id: "active_trials",
                    name: "Active Trials",
                    description: "In total",
                    value: 123,
                    updatedAt: nil
                ),
                ProjectMetrics.Metric(
                    id: "active_subscriptions",
                    name: "Active Subscriptions",
                    description: "In total",
                    value: 12345,
                    updatedAt: nil
                ),
                ProjectMetrics.Metric(
                    id: "mrr",
                    name: "MRR",
                    description: "Monthly Recurring Revenue",
                    value: 1234,
                    updatedAt: nil
                ),
                ProjectMetrics.Metric(
                    id: "revenue",
                    name: "Revenue",
                    description: "Last 28 days",
                    value: 12345,
                    updatedAt: nil
                ),
                ProjectMetrics.Metric(
                    id: "new_customers",
                    name: "New Customers",
                    description: "Last 28 days",
                    value: 12345,
                    updatedAt: nil
                ),
                ProjectMetrics.Metric(
                    id: "active_users",
                    name: "Active Users",
                    description: "Last 28 days",
                    value: 123456,
                    updatedAt: nil
                )
            ]
        )
    }
}

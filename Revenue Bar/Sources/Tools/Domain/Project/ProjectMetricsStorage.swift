//
//  ProjectMetricsStorage.swift
//  Revenue Bar
//
//  Created by Oleh on 03/09/2024.
//

import Foundation

protocol ProjectMetricsStorageType {
    var summary: ProjectMetrics? { get }
    var onChange: VoidNotifier { get }
    func metrics(for projectId: Project.ID) -> ProjectMetrics?
    func set(metrics: ProjectMetrics, for projectId: Project.ID)
    func clearMetrics(for projectId: Project.ID)
}

final class ProjectMetricsStorage: ProjectMetricsStorageType {
    
    init() {
    }
    
    // MARK: - ProjectMetricsStorageType
    
    var summary: ProjectMetrics? {
        var metrics = self.storage.values.asArray
        guard metrics.isEmpty.not else { return nil }
        let first = metrics.removeFirst()
        return metrics.reduce(first, { $0.summing(with: $1) })
    }
    
    let onChange: VoidNotifier = .init()
    
    func metrics(for projectId: Project.ID) -> ProjectMetrics? {
        self.storage[projectId]
    }
    
    func set(metrics: ProjectMetrics, for projectId: Project.ID) {
        self.storage[projectId] = metrics
        self.onChange.send()
    }
    
    func clearMetrics(for projectId: Project.ID) {
        self.storage.removeValue(forKey: projectId)
        self.onChange.send()
    }
    
    // MARK: - Private
    
    private var storage: [Project.ID: ProjectMetrics] = [:]
}

extension ProjectMetrics {
    
    fileprivate func summing(with another: ProjectMetrics) -> ProjectMetrics {
        ProjectMetrics(
            metrics: self.metrics.map { metric in
                ProjectMetrics.Metric(
                    id: metric.id,
                    name: metric.name,
                    description: metric.description,
                    value: metric.value + (another.value(for: metric.id) ?? .zero),
                    updatedAt: metric.updatedAt
                )
            }
        )
    }
    
    private func value(for projectMetricId: ProjectMetrics.Metric.ID) -> Int? {
        self.metrics
            .first(where: { $0.id == projectMetricId })?
            .value
    }
}

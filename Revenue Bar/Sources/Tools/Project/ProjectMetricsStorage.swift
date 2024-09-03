//
//  ProjectMetricsStorage.swift
//  Revenue Bar
//
//  Created by Oleh on 03/09/2024.
//

import Foundation

protocol ProjectMetricsStorageType {
    var summary: ProjectMetrics? { get }
    func metrics(for projectId: Project.ID) -> ProjectMetrics?
    func set(metrics: ProjectMetrics, for projectId: Project.ID)
}

final class ProjectMetricsStorage: ProjectMetricsStorageType {
    
    init() {
    }
    
    // MARK: - ProjectMetricsStorageType
    
    var summary: ProjectMetrics?
    
    func metrics(for projectId: Project.ID) -> ProjectMetrics? {
        self.storage[projectId]
    }
    
    func set(metrics: ProjectMetrics, for projectId: Project.ID) {
        self.storage[projectId] = metrics
    }
    
    // MARK: - Private
    
    private var storage: [Project.ID: ProjectMetrics] = [:]
}

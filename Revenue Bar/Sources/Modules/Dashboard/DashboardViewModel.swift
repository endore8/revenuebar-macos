//
//  DashboardViewModel.swift
//  Revenue Bar
//
//  Created by Oleh on 01/09/2024.
//

import Foundation

@Observable
final class DashboardViewModel {
    
    let projectMetricsStorage: ProjectMetricsStorageType
    
    init(projectMetricsStorage: ProjectMetricsStorageType) {
        self.projectMetricsStorage = projectMetricsStorage
        
        self.update()
        
        self.projectMetricsStorage.onChange
            .sink { [weak self] in
                self?.update()
            }
            .store(in: &self.notitifierContainer)
    }
    
    private(set) var projectMetrics: ProjectMetrics?
    
    var placeholderProjectMetrics: ProjectMetrics {
        ProjectMetrics(
            metrics: (0..<6).map {
                ProjectMetrics.Metric(
                    id: $0.asString,
                    name: "------",
                    description: "----------",
                    value: 1234,
                    updatedAt: nil
                )
            }
        )
    }
    
    // MARK: - Private
    
    private var notitifierContainer: NotifierContainer?
    
    private func update() {
        self.projectMetrics = self.projectMetricsStorage.summary
    }
}

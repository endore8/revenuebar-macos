//
//  DashboardViewModel.swift
//  Revenue Bar
//
//  Created by Oleh on 01/09/2024.
//

import Foundation

@Observable
final class DashboardViewModel {
    
    let projectFetcherService: ProjectFetcherServiceType
    let projectMetricsStorage: ProjectMetricsStorageType
    let projectsStorage: ProjectsStorageType

    init(projectFetcherService: ProjectFetcherServiceType,
         projectMetricsStorage: ProjectMetricsStorageType,
         projectsStorage: ProjectsStorageType) {
        
        self.projectFetcherService = projectFetcherService
        self.projectMetricsStorage = projectMetricsStorage
        self.projectsStorage = projectsStorage
        
        self.updateProjectMetrics()
        self.updateServiceState()
        
        self.projectFetcherService
            .onChange
            .sink { [weak self] in
                self?.updateServiceState()
            }
            .store(in: &self.notitifiersContainer)
            
        self.projectMetricsStorage
            .onChange
            .sink { [weak self] in
                self?.updateProjectMetrics()
            }
            .store(in: &self.notitifiersContainer)
    }
    
    var isDemo: Bool {
        self.projectsStorage.isDemo
    }
    
    private(set) var isReloading: Bool = false
    
    private(set) var lastReloadDate: Date? = nil
    private(set) var lastReloadError: Error? = nil
    
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
    
    func reload() {
        self.projectFetcherService.reload()
    }
    
    // MARK: - Private
    
    private var notitifiersContainer: NotifiersContainer = .init()
    
    private func updateProjectMetrics() {
        self.projectMetrics = self.projectMetricsStorage.summary
    }
    
    private func updateServiceState() {
        self.isReloading = self.projectFetcherService.isReloading
        self.lastReloadDate = self.projectFetcherService.lastReloadDate
        self.lastReloadError = self.projectFetcherService.lastReloadError
    }
}

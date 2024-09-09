//
//  AuthViewModel.swift
//  Revenue Bar
//
//  Created by Oleh on 01/09/2024.
//

import Foundation
import SwiftUI

@Observable
final class AuthViewModel {
    
    let projectFetcher: ProjectFetcherType
    let projectMetricsStorage: ProjectMetricsStorageType
    let projectsStorage: ProjectsStorageType
    
    init(projectFetcher: ProjectFetcherType,
         projectMetricsStorage: ProjectMetricsStorageType,
         projectsStorage: ProjectsStorageType) {
        
        self.projectFetcher = projectFetcher
        self.projectMetricsStorage = projectMetricsStorage
        self.projectsStorage = projectsStorage
        
        self.projectsStorage.clearDemoProjects()
        self.projectMetricsStorage.clearMetrics(for: Project.demoId)
    }
    
    private(set) var isAuthorizing: Bool = false
    
    private(set) var isAuthorized: Bool = false
    
    private(set) var canContinue: Bool = false
    
    private(set) var error: String?
    
    func authorize() {
        guard 
            self.canContinue
        else { return }
        
        self.isAuthorizing = true
        self.error = nil
        self.projectFetcher.fetch(key: key) { [weak self] result in
            asyncOnMainThread {
                self?.handleFetchResult(result)
            }
        }
    }
    
    func prepareDemo() {
        let project = Project.demo
        self.projectsStorage.add(project: project)
        self.projectMetricsStorage.set(metrics: .demo, for: project.id)
        self.isAuthorized = true
    }
    
    func update(key: String) {
        self.key = key.trimmingCharacters(in: .whitespacesAndNewlines)
        self.canContinue = self.key.count >= 8
    }
    
    // MARK: - Private
    
    private var key: String = .empty
    
    private func handleFetchResult(_ result: Result<ProjectFetch, Error>) {
        switch result {
        case .success(let fetch): 
            self.projectsStorage.add(project: fetch.project)
            self.projectMetricsStorage.set(metrics: fetch.metrics, for: fetch.project.id)
            self.isAuthorizing = false
            self.isAuthorized = true
        case .failure(let error):
            self.error = error.localizedDescription
            self.isAuthorizing = false
        }
    }
}

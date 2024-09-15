//
//  ProjectFetcherService.swift
//  Revenue Bar
//
//  Created by Oleh on 04/09/2024.
//

import Foundation

protocol ProjectFetcherServiceType {
    var isReloading: Bool { get }
    var lastReloadDate: Date? { get }
    var lastReloadError: Error? { get }
    var onChange: VoidNotifier { get }
    func reload()
}

final class ProjectFetcherService: ProjectFetcherServiceType {
    
    let projectFetcher: ProjectFetcherType
    let projectMetricsStorage: ProjectMetricsStorageType
    let projectsStorage: ProjectsStorageType
    
    init(projectFetcher: ProjectFetcherType,
         projectMetricsStorage: ProjectMetricsStorageType,
         projectsStorage: ProjectsStorageType) {
        
        self.projectFetcher = projectFetcher
        self.projectMetricsStorage = projectMetricsStorage
        self.projectsStorage = projectsStorage
        
        // Disabled until menu bar component needs background refresh.
//        self.update()
//        
//        self.projectsStorage
//            .onChange
//            .sink { [weak self] in
//                self?.update()
//            }
//            .store(in: &self.notifierContainer)
    }
    
    // MARK: - ProjectFetcherServiceType
    
    private(set) var isReloading: Bool = false
    
    private(set) var lastReloadDate: Date?
    private(set) var lastReloadError: Error?
    
    let onChange: VoidNotifier = .init()
    
    func reload() {
        guard
            self.isReloading.not,
            let projects = self.projectsStorage.projects,
            projects.isEmpty.not
        else { return }
        
        self.isReloading = true
        self.lastReloadError = nil
        self.onChange.send()
        
        var reloadResult: [Project.ID: Result<ProjectFetch, Error>] = [:]
        
        projects.forEach { project in
            self.projectFetcher.fetch(key: project.key) { [weak self] result in
                asyncOnMainThread {
                    reloadResult[project.id] = result
                    if reloadResult.count == projects.count {
                        self?.handlerReloadResult(result: reloadResult)
                    }
                }
            }
        }
    }
    
    // MARK: - Private
    
    private var notifierContainer: NotifierContainer?
    
    private var timer: DispatchSourceTimer?
    
    private func handlerReloadResult(result: [Project.ID: Result<ProjectFetch, Error>]) {
        self.isReloading = false
        
        if let error = result.values.compactMap({ $0.error }).first {
            self.lastReloadError = error
        }
        else {
            result.forEach { projectId, result in
                if let projectFetch = try? result.get() {
                    self.projectsStorage.add(
                        project: projectFetch.project
                    )
                    self.projectMetricsStorage.set(
                        metrics: projectFetch.metrics,
                        for: projectId
                    )
                }
            }
            self.lastReloadDate = .now
        }
        
        self.onChange.send()
    }
    
//    private func update() {
//        if self.projectsStorage.projects.isNotNil && self.projectsStorage.isDemo.not {
//            let timer = DispatchSource.makeTimerSource()
//            timer.setEventHandler { [weak self] in
//                self?.reload()
//            }
//            timer.schedule(deadline: .now(),
//                           repeating: .seconds(60 * 60)) // 1 hour
//            timer.activate()
//            
//            self.timer = timer
//        }
//        else {
//            self.timer?.cancel()
//            self.timer = nil
//        }
//    }
}

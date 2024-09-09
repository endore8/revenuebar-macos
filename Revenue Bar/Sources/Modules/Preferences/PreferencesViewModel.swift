//
//  PreferencesViewModel.swift
//  Revenue Bar
//
//  Created by Oleh on 01/09/2024.
//

import Foundation

@Observable
final class PreferencesViewModel {
    
    let openAtLoginHandler: OpenAtLoginHandlerType
    let projectMetricsStorage: ProjectMetricsStorageType
    let projectsStorage: ProjectsStorageType
    
    init(openAtLoginHandler: OpenAtLoginHandlerType,
         projectMetricsStorage: ProjectMetricsStorageType,
         projectsStorage: ProjectsStorageType) {
        
        self.openAtLoginHandler = openAtLoginHandler
        self.projectMetricsStorage = projectMetricsStorage
        self.projectsStorage = projectsStorage
        
        self.projects = self.projectsStorage.projects ?? []
    }
    
    var isDemo: Bool {
        self.projectsStorage.isDemo
    }
    
    private(set) var projects: [Project] = []
    
    var isOpenAtLogin: Bool {
        get {
            self.openAtLoginHandler.isEnabled
        }
        set {
            self.openAtLoginHandler.isEnabled = newValue
        }
    }
    
    func remove(projectId: Project.ID) {
        self.projectsStorage.remove(projectId: projectId)
        self.projectMetricsStorage.clearMetrics(for: projectId)
        self.projects = self.projectsStorage.projects ?? []
    }
    
    func quitDemo() {
        self.remove(projectId: Project.demoId)
    }
}

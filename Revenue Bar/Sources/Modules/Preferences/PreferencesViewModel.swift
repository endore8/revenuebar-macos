//
//  PreferencesViewModel.swift
//  Revenue Bar
//
//  Created by Oleh on 01/09/2024.
//

import Foundation

@Observable
final class PreferencesViewModel {
    
    let projectsStorage: ProjectsStorageType
    
    init(projectsStorage: ProjectsStorageType) {
        self.projectsStorage = projectsStorage
        
        self.projects = self.projectsStorage.projects ?? []
    }
    
    private(set) var projects: [Project] = []
    
    func remove(projectId: Project.ID) {
        self.projectsStorage.remove(projectId: projectId)
        self.projects = self.projectsStorage.projects ?? []
    }
}

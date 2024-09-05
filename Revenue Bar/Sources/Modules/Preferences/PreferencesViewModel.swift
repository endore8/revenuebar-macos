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
    let projectsStorage: ProjectsStorageType
    
    init(openAtLoginHandler: OpenAtLoginHandlerType,
         projectsStorage: ProjectsStorageType) {
        
        self.openAtLoginHandler = openAtLoginHandler
        self.projectsStorage = projectsStorage
        
        self.projects = self.projectsStorage.projects ?? []
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
        self.projects = self.projectsStorage.projects ?? []
    }
}

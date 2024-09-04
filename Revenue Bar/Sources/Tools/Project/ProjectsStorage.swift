//
//  ProjectsStorage.swift
//  Revenue Bar
//
//  Created by Oleh on 01/09/2024.
//

import Foundation

protocol ProjectsStorageType {
    var projects: [Project]? { get }
    var onChange: VoidNotifier { get }
    func add(project: Project)
    func remove(projectId: Project.ID)
}

struct ProjectsStorage: ProjectsStorageType {
    
    let keyValueStorage: KeyValueStorageType
    
    // MARK: - ProjectsStorageType
    
    var projects: [Project]? {
        self.keyValueStorage[KeyValueStorageKeys.projects]
    }
    
    let onChange: VoidNotifier = .init()

    func add(project: Project) {
        let storedProjects = self.keyValueStorage[KeyValueStorageKeys.projects] ?? []
        guard
            !storedProjects.contains(where: { $0.id == project.id })
        else { return }
        self.keyValueStorage[KeyValueStorageKeys.projects] = storedProjects + [project]
        self.onChange.send()
        if storedProjects.isEmpty {
            // TODO: notify
        }
    }
    
    func remove(projectId: Project.ID) {
        guard
            let storedProjects = self.keyValueStorage[KeyValueStorageKeys.projects]
        else { return }
        let updatedProjects = storedProjects.filter({ $0.id != projectId }).nilIfEmpty
        self.keyValueStorage[KeyValueStorageKeys.projects] = updatedProjects
        self.onChange.send()
        if updatedProjects.isNil {
            // TODO: notify
        }
    }
}

extension Array where Element == Project {
    
    fileprivate var nilIfEmpty: [Element]? {
        self.isEmpty ? nil : self
    }
}

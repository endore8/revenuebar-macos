//
//  ProjectsStorage.swift
//  Revenue Bar
//
//  Created by Oleh on 01/09/2024.
//

import Foundation

protocol ProjectsStorageType {
    var projects: [Project]? { get }
    var isDemo: Bool { get }
    var onChange: VoidNotifier { get }
    func add(project: Project)
    func remove(projectId: Project.ID)
    func clearDemoProjects()
}

struct ProjectsStorage: ProjectsStorageType {
    
    let keyValueStorage: KeyValueStorageType
    
    // MARK: - ProjectsStorageType
    
    var projects: [Project]? {
        self.keyValueStorage[KeyValueStorageKeys.projects]
    }
    
    var isDemo: Bool {
        self.projects?.contains(where: { $0.isDemo }) ?? false
    }
    
    let onChange: VoidNotifier = .init()

    func add(project: Project) {
        var storedProjects = self.keyValueStorage[KeyValueStorageKeys.projects] ?? []
        if let index = storedProjects.firstIndex(where: { $0.id == project.id }) {
            if project != storedProjects[index] {
                storedProjects[index] = project
                self.keyValueStorage[KeyValueStorageKeys.projects] = storedProjects
                self.onChange.send()
            }
        }
        else {
            self.keyValueStorage[KeyValueStorageKeys.projects] = storedProjects + [project]
            self.onChange.send()
        }
    }
    
    func remove(projectId: Project.ID) {
        guard
            let storedProjects = self.keyValueStorage[KeyValueStorageKeys.projects]
        else { return }
        let updatedProjects = storedProjects.filter({ $0.id != projectId }).nilIfEmpty
        self.keyValueStorage[KeyValueStorageKeys.projects] = updatedProjects
        self.onChange.send()
    }
    
    func clearDemoProjects() {
        if let demoProjects = self.projects?.filter({ $0.isDemo }) {
            demoProjects.forEach {
                self.remove(projectId: $0.id)
            }
        }
    }
}

extension Array where Element == Project {
    
    fileprivate var nilIfEmpty: [Element]? {
        self.isEmpty ? nil : self
    }
}

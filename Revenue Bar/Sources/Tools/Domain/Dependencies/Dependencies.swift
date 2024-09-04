//
//  Dependencies.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import Foundation
import KeychainAccess

struct Dependencies {
    
    let projectFetcherService: ProjectFetcherServiceType
    let menuBarController: MenuBarControllerType
    let menuPopoverController: MenuPopoverControllerType
    
    init() {
        
        let securedKeyValueStorage = Keychain()
        
        let projectFetcher = ProjectFetcher(
            session: .shared
        )
        let projectMetricsStorage = ProjectMetricsStorage()
        let projectsStorage = ProjectsStorage(
            keyValueStorage: securedKeyValueStorage
        )
        let projectFetcherService = ProjectFetcherService(
            projectFetcher: projectFetcher,
            projectMetricsStorage: projectMetricsStorage,
            projectsStorage: projectsStorage
        )
        let viewModelFactory = ViewModelFactory(
            projectFetcher: projectFetcher,
            projectMetricsStorage: projectMetricsStorage,
            projectsStorage: projectsStorage
        )
        
        let menuBarController = MenuBarController()
        let menuPopoverController = MenuPopoverController(
            projectsStorage: projectsStorage,
            viewModelFactory: viewModelFactory
        )
        
        self.projectFetcherService = projectFetcherService
        self.menuBarController = menuBarController
        self.menuPopoverController = menuPopoverController
    }
}

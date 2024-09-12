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
        
        let keyValueStorage = UserDefaults.standard
        let securedKeyValueStorage = Keychain()
        
        let openAtLoginHandler = OpenAtLoginHandler(
            appService: .mainApp
        )
        
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
        
        let proStatusProvider = ProStatusProvider(
            keyValueStorage: keyValueStorage
        )
        
        let viewModelFactory = ViewModelFactory(
            openAtLoginHandler: openAtLoginHandler,
            projectFetcher: projectFetcher,
            projectFetcherService: projectFetcherService,
            projectMetricsStorage: projectMetricsStorage,
            projectsStorage: projectsStorage
        )
        
        let menuBarController = MenuBarController()
        let menuPopoverController = MenuPopoverController(
            projectsStorage: projectsStorage,
            proStatusProvider: proStatusProvider,
            viewModelFactory: viewModelFactory
        )
        
        projectsStorage.clearDemoProjects()
        
        self.projectFetcherService = projectFetcherService
        self.menuBarController = menuBarController
        self.menuPopoverController = menuPopoverController
    }
}

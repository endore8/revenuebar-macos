//
//  Dependencies.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import Foundation
import KeychainAccess

struct Dependencies {
    
    let menuBarController: MenuBarControllerType
    let menuPopoverController: MenuPopoverControllerType
    
    init() {
        
        let securedKeyValueStorage = Keychain()
        
        let projectFetcher = ProjectFetcher(
            session: .shared
        )
        let projectsStorage = ProjectsStorage(
            keyValueStorage: securedKeyValueStorage
        )
        let viewModelFactory = ViewModelFactory(
            projectFetcher: projectFetcher,
            projectsStorage: projectsStorage
        )
        
        let menuBarController = MenuBarController()
        let menuPopoverController = MenuPopoverController(
            viewModelFactory: viewModelFactory
        )
        
        self.menuBarController = menuBarController
        self.menuPopoverController = menuPopoverController
    }
}

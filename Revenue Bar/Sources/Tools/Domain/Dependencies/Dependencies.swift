//
//  Dependencies.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import Foundation

struct Dependencies {
    
    let menuBarController: MenuBarControllerType
    let menuPopoverController: MenuPopoverControllerType
    
    init() {
        
        let viewModelFactory = ViewModelFactory()
        
        let menuBarController = MenuBarController()
        let menuPopoverController = MenuPopoverController(
            viewModelFactory: viewModelFactory
        )
        
        self.menuBarController = menuBarController
        self.menuPopoverController = menuPopoverController
    }
}

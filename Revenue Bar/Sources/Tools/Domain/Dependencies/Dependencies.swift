//
//  Dependencies.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import Foundation
import KeychainAccess
import RevenueCat

struct Dependencies {
    
    let menuBarController: MenuBarControllerType
    let menuPopoverController: MenuPopoverControllerType
    let projectFetcherService: ProjectFetcherServiceType
    let projectsStorage: ProjectsStorageType
    let proStatusService: ProStatusServiceType
    
    init() {
        
        let keyValueStorage = UserDefaults.standard
        let keyValueStorageSecured = Keychain()
        
        let deviceId = DeviceIdProvider(
            keyValueStorage: keyValueStorageSecured,
            keyValueStorageBackup: keyValueStorage
        ).id
        
        let openAtLoginHandler = OpenAtLoginHandler(
            appService: .mainApp
        )
        
        let projectFetcher = ProjectFetcher(
            session: .shared
        )
        let projectMetricsStorage = ProjectMetricsStorage()
        let projectsStorage = ProjectsStorage(
            keyValueStorage: keyValueStorageSecured
        )
        let projectFetcherService = ProjectFetcherService(
            projectFetcher: projectFetcher,
            projectMetricsStorage: projectMetricsStorage,
            projectsStorage: projectsStorage
        )
        
        Purchases.logLevel = .warn
        let purchases = Purchases.configure(
            withAPIKey: AppConstants.ThirdParty.revenueCat,
            appUserID: deviceId
        )
        
        let proPurchaseProvider = ProPurchaseRevenueCatProvider(
            keyValueStorage: keyValueStorage,
            purchases: purchases
        )
        let proStatusProvider = ProStatusProvider(
            keyValueStorage: keyValueStorage
        )
        let proStatusService = ProStatusRevenueCatService(
            keyValueStorage: keyValueStorage,
            purchases: purchases
        )
        
        let viewModelFactory = ViewModelFactory(
            openAtLoginHandler: openAtLoginHandler,
            projectFetcher: projectFetcher,
            projectFetcherService: projectFetcherService,
            projectMetricsStorage: projectMetricsStorage,
            projectsStorage: projectsStorage,
            proPurchaseProvider: proPurchaseProvider
        )
        
        let menuBarController = MenuBarController()
        let menuPopoverController = MenuPopoverController(
            projectsStorage: projectsStorage,
            proStatusProvider: proStatusProvider,
            viewModelFactory: viewModelFactory
        )
        
        self.menuBarController = menuBarController
        self.menuPopoverController = menuPopoverController
        self.projectFetcherService = projectFetcherService
        self.projectsStorage = projectsStorage
        self.proStatusService = proStatusService
    }
}

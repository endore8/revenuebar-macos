//
//  OpenAtLoginHandler.swift
//  Revenue Bar
//
//  Created by Oleh on 05/09/2024.
//

import Foundation
import ServiceManagement

protocol OpenAtLoginHandlerType {
    var isEnabled: Bool { get nonmutating set }
}

struct OpenAtLoginHandler: OpenAtLoginHandlerType {
    
    let appService: SMAppService
    
    // MARK: - OpenAtLoginHandlerType

    var isEnabled: Bool {
        get {
            self.appService.status.isEnabled
        }
        nonmutating set {
            if newValue {
                if self.appService.status.isEnabled.not {
                    try? self.appService.register()
                }
            }
            else {
                if self.appService.status.isEnabled {
                    try? self.appService.unregister()
                }
            }
        }
    }
}

extension SMAppService.Status {
    
    fileprivate var isEnabled: Bool {
        self == .enabled || self == .requiresApproval
    }
}

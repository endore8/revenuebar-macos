//
//  Project.swift
//  Revenue Bar
//
//  Created by Oleh on 01/09/2024.
//

import Foundation

struct Project: Codable, Equatable {
    typealias ID = String
    
    let id: ID
    let key: String
    let name: String
    
    var isDemo: Bool {
        self.id == Project.demoId
    }
}

extension Project {
    
    static let demoId: String = "demo"
    
    static var demo: Project {
        Project(
            id: self.demoId,
            key: "demo",
            name: "Demo"
        )
    }
}

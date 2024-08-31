//
//  RevenueBarApp.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import SwiftUI

@main
struct RevenueBarApp: App {
    
    var body: some Scene {
        MenuBarExtra("Utility App", systemImage: "hammer") {
            AuthView()
        }
    }
}

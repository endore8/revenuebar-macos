//
//  DashboardView.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import SwiftUI

struct DashboardView: View {
    
    let onShowPreferences: VoidClosure
    
    var body: some View {
        VStack {
            Text("Dashboard")
            FooterView(
                accessory: .refresh(text: "Now", onRefresh: {}),
                options: [
                    FooterView.Option(
                        title: "Preferences",
                        onAction: self.onShowPreferences
                    )
                ]
            )
        }
    }
    
    @Environment(DashboardViewModel.self)
    var viewModel
}

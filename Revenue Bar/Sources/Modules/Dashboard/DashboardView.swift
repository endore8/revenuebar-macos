//
//  DashboardView.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import SwiftUI

struct DashboardView: View {
    
    var body: some View {
        VStack {
            Text("Dashboard")
            FooterView(accessory: .refresh(text: "Now", onRefresh: {}))
        }
    }
    
    @Environment(DashboardViewModel.self)
    var viewModel
}

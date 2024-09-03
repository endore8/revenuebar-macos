//
//  DashboardView.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import SwiftUI

struct DashboardView: View {
    
    var body: some View {
        Text("Dashboard")
    }
    
    @Environment(DashboardViewModel.self)
    var viewModel
}

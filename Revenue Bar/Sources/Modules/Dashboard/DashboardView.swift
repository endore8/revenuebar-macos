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
            LazyVGrid(columns: self.columns) {
                if let projectMetrics = self.viewModel.projectMetrics {
                    ForEach(projectMetrics.metrics) { projectMetric in
                        self.projectMetricView(projectMetric: projectMetric)
                    }
                }
                else {
                    ForEach(self.viewModel.placeholderProjectMetrics.metrics) { projectMetric in
                        self.projectMetricView(projectMetric: projectMetric)
                    }
                    .redacted(reason: .placeholder)
                }
            }
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
        .background(.background.secondary)
    }
    
    @ViewBuilder
    private func projectMetricView(projectMetric: ProjectMetrics.Metric) -> some View {
        VStack {
            Text(projectMetric.name)
                .font(.subheadline)
                .foregroundStyle(.primary)
            Text(projectMetric.value.asString)
                .font(.title3)
                .foregroundStyle(.primary)
            Text(projectMetric.description)
                .font(.footnote)
                .foregroundStyle(.secondary)
            if let date = projectMetric.updatedAt {
                Text(date.ISO8601Format())
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    private let columns: [GridItem] = Array(
        repeating: GridItem(
            .flexible(),
            spacing: .Spacing.inner
        ),
        count: 2
    )
    
    @Environment(DashboardViewModel.self)
    private var viewModel
}

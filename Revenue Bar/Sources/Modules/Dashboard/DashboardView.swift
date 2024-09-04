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
        VStack(spacing: .Spacing.none) {
            LazyVGrid(columns: self.columns,
                      spacing: .Spacing.inner) {
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
            .padding(.Padding.inner)
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
    
    @ViewBuilder
    private func projectMetricView(projectMetric: ProjectMetrics.Metric) -> some View {
        VStack(alignment: .leading,
               spacing: .Spacing.small) {
            Text(projectMetric.name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(projectMetric.value.asString)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
            Text(projectMetric.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.Padding.inner)
        .background(.background.secondary)
        .cornerRadius(.CornerRadius.ten)
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

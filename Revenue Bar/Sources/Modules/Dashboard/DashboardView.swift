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
            if self.viewModel.isDemo {
                DemoView(onQuit: self.viewModel.quitDemo)
            }
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
            .padding(.horizontal, .Padding.inner)
            .padding(.vertical, .Padding.middle)
            FooterView(
                accessory: self.footerAccessory,
                options: [
                    FooterView.Option(
                        title: "Preferences",
                        onAction: self.onShowPreferences
                    )
                ]
            )
        }
        .onAppear {
            if self.viewModel.isReloading.not {
                self.viewModel.reload()
            }
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
            Text(projectMetric.valueFormatted)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
            Text(projectMetric.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.Padding.inner)
        .border(
            .primary.opacity(.Opacity.separator),
            width: .BorderWidth.thick,
            cornerRadius: .CornerRadius.ten
        )
    }
    
    private let columns: [GridItem] = Array(
        repeating: GridItem(
            .flexible(),
            spacing: .Spacing.inner
        ),
        count: 2
    )
    
    private var footerAccessory: FooterView.Accessory {
        if self.viewModel.isReloading {
            .loading
        }
        else if self.viewModel.lastReloadError.isNotNil {
            .error(text: "Couldn't reload", onRetry: self.viewModel.reload)
        }
        else if let date = self.viewModel.lastReloadDate {
            .refresh(text: date.relativeToNowFormatted, onRefresh: self.viewModel.reload)
        }
        else {
            .none
        }
    }
    
    @Environment(DashboardViewModel.self)
    private var viewModel
}

extension ProjectMetrics.Metric {
    
    fileprivate var valueFormatted: String {
        switch self.id {
        case "mrr", "revenue": "$" + self.value.decimalFormatted
        default: self.value.decimalFormatted
        }
    }
}

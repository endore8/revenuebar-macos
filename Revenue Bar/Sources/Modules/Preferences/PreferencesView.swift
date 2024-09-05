//
//  PreferencesView.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import SwiftUI

struct PreferencesView: View {
    
    let onAddProject: VoidClosure
    let onDismiss: VoidClosure
    
    var body: some View {
        VStack(spacing: .Spacing.none) {
            HeaderView(
                title: "Preferences",
                onDismiss: self.onDismiss
            )
            self.contentView
            FooterView()
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        VStack(spacing: .Spacing.none) {
            HStack(alignment: .center,
                   spacing: .Spacing.inner) {
                Text("Projects")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button(action: self.onAddProject) {
                    Image(systemName: "plus.app")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.bottom, .Padding.compact)
            ForEach(self.viewModel.projects, id: \.id) { project in
                PreferencesProjectView(
                    project: project,
                    onRemove: self.viewModel.remove(projectId:)
                )
            }
        }
        .padding(.Padding.inner)
    }
    
    @Environment(PreferencesViewModel.self)
    private var viewModel
}

struct PreferencesProjectView: View {
    
    let project: Project
    let onRemove: TypeClosure<Project.ID>
    
    var body: some View {
        HStack(alignment: .center,
               spacing: .Spacing.inner) {
            Text(self.project.name)
                .font(.body)
                .fontWeight(.medium)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button(action: { self.onRemove(self.project.id) }) {
                Image(systemName: "minus.circle")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal, .Padding.small)
            .hidden(if: self.isHovering.not)
        }
        .padding(.vertical, .Padding.compact)
        .onHover {
            self.isHovering = $0
        }
    }
    
    @State
    private var isHovering: Bool = false
}

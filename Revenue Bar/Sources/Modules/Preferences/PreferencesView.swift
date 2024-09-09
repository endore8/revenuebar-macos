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
            if self.viewModel.isDemo {
                DemoView(onQuit: self.viewModel.quitDemo)
            }
            HeaderView(
                title: "Preferences",
                onDismiss: self.onDismiss
            )
            self.contentView
            FooterView()
        }
        .task {
            self.isOpenAtLogin = self.viewModel.isOpenAtLogin
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        VStack(spacing: .Spacing.inner) {
            self.projectsView
            SeparatorView()
            self.preferencesView
        }
        .padding(.Padding.inner)
    }
    
    @ViewBuilder
    private var projectsView: some View {
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
    }
    
    @ViewBuilder
    private var preferencesView: some View {
        VStack(spacing: .Spacing.none) {
            HStack(alignment: .center, 
                   spacing: .Spacing.inner) {
                Text("Open at login")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Toggle(isOn: self.$isOpenAtLogin) {
                    Text(String.empty)
                }
                .labelsHidden()
                .toggleStyle(.checkbox)
                .onChange(of: self.isOpenAtLogin) { _, newValue in
                    self.viewModel.isOpenAtLogin = newValue
                }
            }
            .padding(.trailing, .Padding.small)
        }
    }
    
    @State 
    private var isOpenAtLogin: Bool = false
        
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

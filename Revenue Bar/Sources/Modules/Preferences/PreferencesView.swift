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
        VStack {
            HeaderView(
                title: "Preferences",
                onDismiss: self.onDismiss
            )
            HStack {
                Text("Projects")
                Button(action: self.onAddProject) {
                    Image(systemName: "plus.circle")
                }
            }
            ForEach(self.viewModel.projects, id: \.id) { project in
                PreferencesProjectView(
                    project: project,
                    onRemove: self.viewModel.remove(projectId:)
                )
            }
            FooterView()
        }
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
            Text(project.name)
            Spacer()
            Button(action: { self.onRemove(self.project.id) }) {
                Image(systemName: "minus.circle")
            }
            .buttonStyle(PlainButtonStyle())
            .hidden(if: self.isHovering.not)
        }
        .onHover {
            self.isHovering = $0
        }
    }
    
    @State
    private var isHovering: Bool = false
}

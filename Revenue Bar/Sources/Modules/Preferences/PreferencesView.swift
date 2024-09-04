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
                self.projectView(project: project)
            }
            FooterView()
        }
    }
    
    @ViewBuilder
    private func projectView(project: Project) -> some View {
        HStack {
            Text(project.name)
            Spacer()
            Button(action: { self.viewModel.remove(projectId: project.id) }) {
                Image(systemName: "minus.circle")
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    @Environment(PreferencesViewModel.self)
    private var viewModel
}

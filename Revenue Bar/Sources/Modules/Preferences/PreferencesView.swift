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
        HStack {
            Text(project.name)
            Spacer()
            Button(action: { self.isDeletionConfirmationDialogPresented = true }) {
                Image(systemName: "minus.circle")
            }
            .buttonStyle(PlainButtonStyle())
        }
        .confirmationDialog(
            "Remove project \(project.name)?",
            isPresented: self.$isDeletionConfirmationDialogPresented,
            titleVisibility: .visible) {
                Button(
                    "Confirm",
                    action: {
                        self.onRemove(self.project.id)
                    }
                )
                Button(
                    "Cancel",
                    role: .cancel,
                    action: {}
                )
            }
    }
    
    @State
    private var isDeletionConfirmationDialogPresented: Bool = false
}

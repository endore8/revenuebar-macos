//
//  PreferencesView.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import SwiftUI

struct PreferencesView: View {
    
    let onDismiss: VoidClosure
    
    var body: some View {
        VStack {
            HeaderView(onDismiss: self.onDismiss)
            Text("Projects")
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

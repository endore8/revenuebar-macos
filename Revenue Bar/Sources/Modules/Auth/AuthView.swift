//
//  AuthView.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import SwiftUI
  
struct AuthView: View {
    
    let onDismiss: VoidClosure
    let onDone: VoidClosure
    
    var body: some View {
        VStack(spacing: .Spacing.none) {
            HeaderView(
                title: "Get Started",
                onDismiss: self.onDismiss
            )
            self.contentView
            FooterView()
        }
        .disabled(self.viewModel.isAuthorizing || self.viewModel.isAuthorized)
        .onChange(of: self.key) { _, newValue in
            self.viewModel.update(key: newValue)
        }
        .onChange(of: self.viewModel.isAuthorized) { _, newValue in
            if newValue {
                self.onDone()
            }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        VStack(alignment: .leading, 
               spacing: .Spacing.none) {
            Text("Enter secret key")
            TextField(
                "Secret key",
                text: self.$key,
                onCommit: self.continue
            )
            .font(.title3)
            .foregroundStyle(.primary)
            .padding(.Padding.compact)
            .textFieldStyle(PlainTextFieldStyle())
            Button("Continue", action: self.continue)
                .disabled(self.viewModel.canContinue.not)
            if let error = self.viewModel.error {
                Text(error)
            }
            if self.viewModel.isAuthorizing {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        .padding(.Padding.inner)
    }
    
    @State
    private var key: String = .empty
    
    @Environment(AuthViewModel.self)
    private var viewModel
    
    private func `continue`() {
        self.viewModel.authorize()
    }
}

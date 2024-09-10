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
            FooterView(
                accessory: .action(
                    title: "See demo",
                    onAction: self.continueWithDemo
                )
            )
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
               spacing: .Spacing.outer) {
            VStack(alignment: .leading,
                   spacing: .Spacing.inner) {
                HStack(alignment: .top,
                       spacing: .Spacing.inner) {
                    Image(systemName: "1.square")
                        .font(.title)
                        .foregroundStyle(.primary)
                    Text("Go to the **[RevenueCat](https://app.revenuecat.com)** and open your project's settings.")
                        .font(.title3)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(.zero)
                }
                HStack(alignment: .top,
                       spacing: .Spacing.inner) {
                    Image(systemName: "2.square")
                        .font(.title)
                        .foregroundStyle(.primary)
                    Text("Select **API Keys** in the **Project Settings** panel.")
                        .font(.title3)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)
                }
            }
            VStack(alignment: .leading,
                   spacing: .Spacing.inner) {
                TextField(
                    "Secret key",
                    text: self.$key,
                    onCommit: self.continue
                )
                .font(.title3)
                .foregroundStyle(.primary)
                .padding(.Padding.compact)
                .textFieldStyle(PlainTextFieldStyle())
                HStack(spacing: .Spacing.inner) {
                    Text("Couldn't fetch data")
                        .font(.body)
                        .foregroundStyle(.orange)
                        .hidden(if: self.viewModel.error.isNil)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Button(action: self.continue) {
                        HStack(alignment: .center,
                               spacing: .Spacing.small) {
                            Text("Continue")
                            ZStack {
                                Image(systemName: "chevron.right")
                                    .hidden(if: self.viewModel.isAuthorizing)
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .controlSize(.small)
                                    .hidden(if: self.viewModel.isAuthorizing.not)
                                    .frame(height: .zero)
                            }
                        }
                               .font(.body)
                               .fontWeight(.medium)
                               .foregroundStyle(.primary)
                               .padding(.horizontal, .Padding.compact)
                               .padding(.vertical, .Padding.small)
                               .background(.background.secondary)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .disabled(self.viewModel.canContinue.not || self.viewModel.isAuthorizing)
                }
            }
        }
        .padding(.horizontal, .Padding.inner)
        .padding(.vertical, .Padding.middle)
    }
    
    @State
    private var key: String = .empty
    
    @Environment(AuthViewModel.self)
    private var viewModel
    
    private func `continue`() {
        self.viewModel.authorize()
    }
    
    private func continueWithDemo() {
        self.viewModel.prepareDemo()
    }
}

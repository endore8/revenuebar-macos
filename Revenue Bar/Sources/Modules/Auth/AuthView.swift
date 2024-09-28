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
                accessory: self.footerAccessory
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
            self.contentStepsView
            VStack(alignment: .leading,
                   spacing: .Spacing.inner) {
                self.contentSecretKeyView
                self.contentFooterView
            }
        }
        .padding(.horizontal, .Padding.inner)
        .padding(.vertical, .Padding.middle)
    }
    
    @ViewBuilder
    private var contentStepsView: some View {
        VStack(alignment: .leading,
               spacing: .Spacing.inner) {
            Text("Provide a limited access secret key\nwith read-only access\nto your RevenueCat project.")
                .fixedSize(horizontal: false, vertical: true)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
            StepView(
                symbol: "1.square.fill",
                text: "Open **[RevenueCat](https://app.revenuecat.com)** website."
            )
            StepView(
                symbol: "2.square.fill",
                text: "Open **Project Settings** page."
            )
            StepView(
                symbol: "3.square.fill",
                text: "Select **API Keys** in\nthe **Project Settings** panel."
            )
            StepView(
                symbol: "4.square.fill",
                text: "Press **+ New** button."
            )
            StepView(
                symbol: "5.square.fill",
                text: "Give it a name (e.g. RevenueBar)."
            )
            StepView(
                symbol: "6.square.fill",
                text: "Choose API version **V2**."
            )
            StepView(
                symbol: "7.square.fill",
                text: "Change permissions for\n**Chart metrics permissions** to **Read only**."
            )
            StepView(
                symbol: "8.square.fill",
                text: "Change permissions for\n**Project configuration permissions**\nto **Read only**."
            )
            StepView(
                symbol: "9.square.fill",
                text: "Press **Generate** button."
            )
            StepView(
                symbol: "10.square.fill",
                text: "Paste the generated key in the field below."
            )
        }
    }
    
    @ViewBuilder
    private var contentSecretKeyView: some View {
        TextField(
            "Secret key",
            text: self.$key,
            onCommit: self.continue
        )
        .tint(.pink)
        .focused(self.$isSecretKeyTextFieldFocused)
        .font(.title3)
        .foregroundStyle(.primary)
        .padding(.horizontal, .Padding.inner)
        .padding(.vertical, .Padding.compact)
        .overlay(
            RoundedRectangle(cornerRadius: .CornerRadius.four)
                .stroke(
                    self.isSecretKeyTextFieldFocused ? .blue.opacity(.Opacity.dimmed) : .primary.opacity(.Opacity.separator),
                    lineWidth: .BorderWidth.thin
                )
        )
        .textFieldStyle(PlainTextFieldStyle())
    }
    
    @ViewBuilder
    private var contentFooterView: some View {
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
                .padding(.horizontal, .Padding.inner)
                .padding(.vertical, .Padding.compact)
                .background(.blue.gradient)
                .clipShape(RoundedRectangle(cornerRadius: .CornerRadius.four))
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(self.viewModel.canContinue.not || self.viewModel.isAuthorizing)
        }
    }
    
    @FocusState
    private var isSecretKeyTextFieldFocused: Bool
    
    @State
    private var key: String = .empty
    
    @Environment(AuthViewModel.self)
    private var viewModel
    
    private var footerAccessory: FooterView.Accessory {
        self.viewModel.isFirstAuthorization ? 
            .action(title: "See demo", onAction: self.continueWithDemo) :
            .none
    }
    
    private func `continue`() {
        self.viewModel.authorize()
    }
    
    private func continueWithDemo() {
        self.viewModel.prepareDemo()
    }
}

private struct StepView: View {
    
    let symbol: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top,
               spacing: .Spacing.inner) {
            Image(systemName: self.symbol)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
            Text(self.text.asMarkdownAttributedString)
                .fixedSize(horizontal: false, vertical: true)
                .font(.title3)
                .foregroundStyle(.primary)
                .padding(.top, .Padding.small)
        }
    }
}

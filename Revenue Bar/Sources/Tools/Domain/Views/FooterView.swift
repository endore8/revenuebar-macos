//
//  FooterView.swift
//  Revenue Bar
//
//  Created by Oleh on 03/09/2024.
//

import SwiftUI

struct FooterView: View {
    
    enum Accessory {
        case action(title: String, onAction: VoidClosure)
        case refresh(text: String, onRefresh: VoidClosure)
        case error(text: String, onRetry: VoidClosure)
        case loading
        case none
    }
    
    struct Option {
        let title: String
        let onAction: VoidClosure
    }
    
    let accessory: Accessory
    let options: [Option]
    
    init(accessory: Accessory = .none,
         options: [Option] = []) {
        
        self.accessory = accessory
        self.options = options
    }
    
    var body: some View {
        VStack(spacing: .Spacing.none) {
            SeparatorView()
            HStack(alignment: .center,
                   spacing: .Spacing.inner) {
                self.accessoryView
                Spacer()
                self.optionsView
            }
            .padding(.horizontal, .Padding.inner)
            .padding(.vertical, .Padding.compact)
        }
    }
    
    @ViewBuilder
    private var accessoryView: some View {
        switch self.accessory {
        case .action(let title, let onAction):
            Button(action: onAction) {
                HStack(alignment: .center,
                       spacing: .Spacing.compact) {
                Text(title)
                    .font(.footnote)
                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .foregroundStyle(.secondary)
        case .refresh(let text, let onRefresh):
            HStack(alignment: .center,
                   spacing: .Spacing.compact) {
                Button(action: onRefresh) {
                    Image(systemName: "arrow.clockwise")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .buttonStyle(PlainButtonStyle())
                Text(text)
                    .font(.footnote)
            }
            .foregroundStyle(.secondary)
        case .error(let text, let onRetry):
            HStack(alignment: .center,
                   spacing: .Spacing.compact) {
                Button(action: onRetry) {
                    Image(systemName: "arrow.clockwise")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .buttonStyle(PlainButtonStyle())
                Text(text)
                    .font(.footnote)
                    .foregroundStyle(.orange)
            }
            .foregroundStyle(.secondary)
        case .loading:
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .controlSize(.small)
                .frame(height: .zero)
        case .none:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var optionsView: some View {
        MenuButton(
            label: ZStack {
                Image(systemName: "ellipsis")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    .symbolRenderingMode(.palette)
            }.padding(.Padding.small).background(.background.secondary),
            content: {
                ForEach(self.options, id: \.title) { option in
                    Button(option.title, action: option.onAction)
                }
                Button("Quit", action: self.quit)
            }
        )
        .frame(width: 20)
        .menuButtonStyle(BorderlessButtonMenuButtonStyle())
    }
    
    private func quit() {
        NSApp.terminate(self)
    }
}

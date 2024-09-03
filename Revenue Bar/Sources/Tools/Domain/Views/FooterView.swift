//
//  FooterView.swift
//  Revenue Bar
//
//  Created by Oleh on 03/09/2024.
//

import SwiftUI

struct FooterView: View {
    
    enum Accessory {
        case refresh(text: String, onRefresh: VoidClosure)
        case loading
        case none
    }
    
    let accessory: Accessory
    
    init(accessory: Accessory = .none) {
        self.accessory = accessory
    }
    
    var body: some View {
        HStack(alignment: .center) {
            self.accessoryView
            Spacer()
            self.optionsView
        }
    }
    
    @ViewBuilder
    private var accessoryView: some View {
        switch self.accessory {
        case .refresh(let text, let onRefresh):
            HStack(alignment: .center) {
                Button(action: onRefresh) {
                    Image(systemName: "arrow.clockwise")
                }
                .buttonStyle(PlainButtonStyle())
                Text(text)
            }
            .font(.subheadline)
            .foregroundStyle(.primary)
        case .loading:
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .controlSize(.small)
        case .none:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var optionsView: some View {
        MenuButton(
            label: Image(systemName: "ellipsis")
                .font(.subheadline)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.primary),
            content: {
                Button("Quit", action: self.quit)
            }
        )
        .frame(maxWidth: 24, alignment: .trailing)
        .menuButtonStyle(BorderlessButtonMenuButtonStyle())
    }
    
    private func quit() {
        NSApp.terminate(self)
    }
}

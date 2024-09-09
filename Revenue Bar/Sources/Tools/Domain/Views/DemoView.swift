//
//  DemoView.swift
//  Revenue Bar
//
//  Created by Oleh on 09/09/2024.
//

import SwiftUI

struct DemoView: View {
    
    let onQuit: VoidClosure
    
    var body: some View {
        HStack(spacing: .Spacing.inner) {
            Text("This is Demo")
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
            Button(action: self.onQuit) {
                HStack(spacing: .Spacing.compact) {
                    Text("Quit")
                    Image(systemName: "arrow.right.to.line")
                        .fontWeight(.semibold)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing, .Padding.compact)
        }
        .font(.subheadline)
        .foregroundStyle(.white)
        .padding(.horizontal, .Padding.inner)
        .padding(.vertical, .Padding.compact)
        .background(Color.pink)
    }
}

//
//  PurchaseProView.swift
//  Revenue Bar
//
//  Created by Oleh on 12/09/2024.
//

import SwiftUI

struct PurchaseProView: View {
    
    let onDone: VoidClosure
    let onDismiss: VoidClosure
    
    var body: some View {
        VStack(spacing: .Spacing.none) {
            HeaderView(
                title: "Become Pro",
                onDismiss: self.onDismiss
            )
            self.contentView
            FooterView()
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        Text("Content")
    }
        
    @Environment(PurchaseProViewModel.self)
    private var viewModel
}

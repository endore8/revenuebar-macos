//
//  HeaderView.swift
//  Revenue Bar
//
//  Created by Oleh on 03/09/2024.
//

import SwiftUI

struct HeaderView: View {
    
    let onDismiss: VoidClosure
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: self.onDismiss) {
                Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundStyle(.primary)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

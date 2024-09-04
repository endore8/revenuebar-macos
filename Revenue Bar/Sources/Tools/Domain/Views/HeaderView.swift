//
//  HeaderView.swift
//  Revenue Bar
//
//  Created by Oleh on 03/09/2024.
//

import SwiftUI

struct HeaderView: View {
    
    let title: String?
    let onDismiss: VoidClosure
    
    init(title: String? = nil,
         onDismiss: @escaping VoidClosure) {
        
        self.title = title
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        HStack {
            if let title {
                Text(title)
                    .font(.title3)
                    .foregroundStyle(.primary)
            }
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

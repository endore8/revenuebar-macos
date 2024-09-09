//
//  DemoView.swift
//  Revenue Bar
//
//  Created by Oleh on 09/09/2024.
//

import SwiftUI

struct DemoView: View {
    
    var body: some View {
        ZStack {
            Text("This is Demo")
                .font(.subheadline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, .Padding.inner)
        .padding(.vertical, .Padding.compact)
        .background(Color.pink)
    }
}

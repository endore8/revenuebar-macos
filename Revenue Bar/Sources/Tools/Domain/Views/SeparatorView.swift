//
//  SeparatorView.swift
//  Revenue Bar
//
//  Created by Oleh on 09/09/2024.
//

import SwiftUI

struct SeparatorView: View {
    
    var body: some View {
        Rectangle()
            .fill(.primary.opacity(.Opacity.separator))
            .frame(height: .one)
    }
}

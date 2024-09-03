//
//  PreferencesView.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import SwiftUI

struct PreferencesView: View {
    
    let onDismiss: VoidClosure
    
    var body: some View {
        VStack {
            HeaderView(onDismiss: self.onDismiss)
            Text("Preferences")
            FooterView()
        }
    }
    
    @Environment(PreferencesViewModel.self)
    private var viewModel
}

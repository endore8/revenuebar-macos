//
//  PreferencesView.swift
//  Revenue Bar
//
//  Created by Oleh on 31/08/2024.
//

import SwiftUI

struct PreferencesView: View {
    
    var body: some View {
        VStack {
            Text("Preferences")
            FooterView()
        }
    }
    
    @Environment(PreferencesViewModel.self)
    private var viewModel
}

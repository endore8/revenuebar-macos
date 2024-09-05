//
//  HiddenIf.swift
//  Revenue Bar
//
//  Created by Oleh on 05/09/2024.
//

import Foundation
import SwiftUI

extension View {
    
    func hidden(if hidden: Bool) -> some View {
        self.modifier(HiddenIf(hidden: hidden))
    }
}

private struct HiddenIf: ViewModifier {
    
    let hidden: Bool
    
    func body(content: Content) -> some View {
        if self.hidden {
            content
                .hidden()
        }
        else {
            content
        }
    }
}

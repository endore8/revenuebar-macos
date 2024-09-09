//
//  Border.swift
//  Revenue Bar
//
//  Created by Oleh on 09/09/2024.
//

import SwiftUI

extension View {
    
    func border(_ shapeStyle: any ShapeStyle, width: CGFloat, cornerRadius: CGFloat = .zero) -> some View {
        self.modifier(
            Border(
                cornerRadius: cornerRadius,
                shapeStyle: shapeStyle,
                width: width
            )
        )
    }
}

private struct Border: ViewModifier {
    
    let cornerRadius: CGFloat
    let shapeStyle: any ShapeStyle
    let width: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: self.cornerRadius)
                    .stroke(AnyShapeStyle(self.shapeStyle), lineWidth: self.width)
            )
    }
}

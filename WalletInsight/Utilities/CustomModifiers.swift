//
//  CustomModifiers.swift
//  TravelNanban
//
//  Created by Sivasankar on 26/2/25.
//

import SwiftUI
import DesignSystem

struct AnimatableScaleEffect: ViewModifier {
    var scaleOne: CGFloat = 1.0
    var scaleTwo: CGFloat = 1.25
    var condition: Bool
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(condition ? scaleOne : scaleTwo)
    }
}

struct WiPrimaryButtonTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, Spacing.small)
            .padding(.horizontal, Spacing.xl)
            .fontWeight(.bold)
            .foregroundStyle(Color.white)
    }
}

struct WiSecondaryButtonTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, Spacing.small)
            .padding(.horizontal, Spacing.xl)
            .fontWeight(.bold)
            .foregroundStyle(Color.primary)
    }
}

struct WiPrimaryButtonStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: CornerRadius.level3))
            .tint(.actionPrimary)
    }
}

struct WiSecondaryButtonStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: CornerRadius.level3))
            .tint(.borderSubtle.opacity(0.5))
    }
}

extension View {
    func wiSecondaryButtonTextStyle() -> some View {
        modifier(WiSecondaryButtonTextModifier())
    }
    
    func wiPrimaryButtonTextStyle() -> some View {
        modifier(WiPrimaryButtonTextModifier())
    }
    
    func wiSecondaryButtonStyleModifier() -> some View {
        modifier(WiSecondaryButtonStyleModifier())
    }
    
    func wiPrimaryButtonStyleModifier() -> some View {
        modifier(WiPrimaryButtonStyleModifier())
    }
}

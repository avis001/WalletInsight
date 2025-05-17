//
//  CustomModifiers.swift
//  TravelNanban
//
//  Created by Sivasankar on 26/2/25.
//

import SwiftUI

struct AnimatableScaleEffect: ViewModifier {
    var scaleOne: CGFloat = 1.0
    var scaleTwo: CGFloat = 1.25
    var condition: Bool
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(condition ? scaleOne : scaleTwo)
    }
}

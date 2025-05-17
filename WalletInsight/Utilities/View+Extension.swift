//
//  View+Extension.swift
//  TravelNanban
//
//  Created by Sivasankar on 25/2/25.
//

import SwiftUI

extension View {
    func hitTestablePadding() -> some View {
        self.padding().contentShape(Rectangle())
    }
}

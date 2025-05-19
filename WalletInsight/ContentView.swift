//
//  ContentView.swift
//  WalletInsight
//
//  Created by Sivasankar on 15/5/25.
//

import SwiftUI

struct ContentView: View {
    private var authService: AuthenticationServiceProtocol
    
    init(authService: AuthenticationServiceProtocol) {
        self.authService = authService
    }
    
    var body: some View {
        AuthenticationSplashView(authService: authService)
            .background(.backgroundMain)
    }
}

#Preview {
    ContentView(authService: MockAuthenticationService.previewMock)
}

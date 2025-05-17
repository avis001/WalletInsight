//
//  WalletInsightApp.swift
//  WalletInsight
//
//  Created by Sivasankar on 15/5/25.
//

import SwiftUI
import Firebase

@main
struct WalletInsightApp: App {
    private let authService: AuthenticationService
    
    init() {
        FirebaseApp.configure()
        authService = AuthenticationService()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(authService: authService)
        }
    }
}

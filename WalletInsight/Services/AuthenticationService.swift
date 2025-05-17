//
//  AuthenticationService.swift
//  TravelNanban
//
//  Created by Sivasankar on 27/2/25.
//

import FirebaseAuth
import Combine
import SwiftUI

@MainActor
protocol AuthenticationServiceProtocol {
    func signUp(withEmail email: String, password: String, firstName: String, lastName: String) async throws -> FirebaseAuth.User
    func signIn(withEmail email: String, password: String) async throws -> FirebaseAuth.User
    func signOut() async throws
    var currentUser: User? { get }
}

@MainActor
class AuthenticationService: ObservableObject, AuthenticationServiceProtocol {
    @Published private(set) var currentUser: User?
    
    private var listenerRegistration: NSObjectProtocol?
    
    init() {
        // Use addStateDidChangeListener for real-time auth state tracking
        // This callback approach is Firebase's recommended pattern for auth state observation
        listenerRegistration = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                self?.currentUser = user
            }
        }
    }
    
    deinit {
        if let listenerRegistration {
            Auth.auth().removeStateDidChangeListener(listenerRegistration)
        }
    }
    
    func signUp(withEmail email: String, password: String, firstName: String, lastName: String) async throws -> FirebaseAuth.User {
        let createUserResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return createUserResult.user
    }
    
    func signIn(withEmail email: String, password: String) async throws -> FirebaseAuth.User {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return authResult.user
    }
    
    func signOut() async throws {
        try Auth.auth().signOut()
    }
}

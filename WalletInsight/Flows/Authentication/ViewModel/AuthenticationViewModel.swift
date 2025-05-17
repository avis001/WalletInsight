//
//  AuthenticationViewModel.swift
//  TravelNanban
//
//  Created by Sivasankar on 26/2/25.
//

import SwiftUI
import Combine
import FirebaseAuth

enum AuthPath {
    case signIn, signUp
    
    var pathTitle: LocalizedStringKey {
        switch self {
        case .signIn:
            return "signIn"
        case .signUp:
            return "signUp"
        }
    }
    
    @ViewBuilder
    var clipShape: some Shape {
        UnevenRoundedRectangle(
            topLeadingRadius: self == .signIn ? 0 : 60,
            topTrailingRadius: self == .signUp ? 0 : 60
        )
    }
}

@Observable
final class AuthenticationViewModel {
    private let authService: AuthenticationServiceProtocol
    private(set) var authPath = AuthPath.signIn
    private(set) var isProcessing = false
    private(set) var errorMessage: String?
    
    init(authService: AuthenticationServiceProtocol) {
        self.authService = authService
    }
    
    func updateAuthPath(_ path: AuthPath) {
        authPath = path
        isProcessing = false
        errorMessage = nil
    }
    
    @MainActor
    func signUp(email: String, password: String, firstName: String, lastName: String) async {
        // Guard against concurrent operations
        guard !isProcessing else { return }
        
        guard !email.isEmpty, !password.isEmpty, !firstName.isEmpty, !lastName.isEmpty else {
            errorMessage = "Please fill in all fields"
            return
        }
        
        isProcessing = true
        errorMessage = nil
        
        do {
            let user = try await authService.signUp(withEmail: email, password: password, firstName: firstName, lastName: lastName)
            // Handle successful sign up
            print("User signed up: \(user.uid)")
        } catch {
            let nsError = error as NSError
            guard nsError.domain == AuthErrorDomain else {
                return
            }
            
            let authErrorCode = AuthErrorCode(rawValue: nsError.code)
            
            switch authErrorCode {
            case .invalidEmail:
                errorMessage = "The email address you entered is not valid. Please check and try again."
            case .emailAlreadyInUse:
                errorMessage = "This email address is already associated with an account. Please log in or use a different email."
            case .weakPassword:
                let reason = nsError.localizedDescription
                errorMessage = "The password is too weak. \(reason)"
                
            case .operationNotAllowed:
                errorMessage = "Email/Password sign-up is not enabled. Please contact support."
                
            case .internalError:
                
                if let underlyingError = nsError.userInfo[NSUnderlyingErrorKey] as? NSError,
                   let responseDict = underlyingError.userInfo["FIRAuthErrorUserInfoDeserializedResponseKey"] as? [String: Any],
                   let backendMessage = responseDict["message"] as? String {
                    
                    print("Backend message: \(backendMessage)") // Log the detailed message for debugging
                    
                    // Check if it's the password requirements error
                    if backendMessage.contains("PASSWORD_DOES_NOT_MEET_REQUIREMENTS") {
                        // You can provide a general message or try to parse the specifics
                        errorMessage = "Password does not meet requirements. Password must contain a lower case character, Password must contain an upper case character, Password must contain a non-alphanumeric character."
                        // Advanced: Parse the specific requirements from the message string if desired
                        // e.g., if backendMessage.contains("lower case character") { ... }
                    } else {
                        // It's some other internal error
                        errorMessage = "An internal server error occurred. Please try again later."
                        print("Unhandled internal error message: \(backendMessage)")
                    }
                } else {
                    // Could not parse underlying error details, use generic internal error message
                    errorMessage = "An internal server error occurred. Please try again."
                    print("Internal error occurred, but couldn't parse underlying details. Error: \(nsError)")
                }
                
            default:
                errorMessage = "An error occurred during sign-up. Please try again later."
            }
        }
        
        isProcessing = false
    }
    
    @MainActor
    func signIn(email: String, password: String) async {
        // Guard against concurrent operations
        guard !isProcessing else { return }
        
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter email and password"
            return
        }
        
        isProcessing = true
        errorMessage = nil
        
        do {
            let user = try await authService.signIn(withEmail: email, password: password)
            // Handle successful sign in
            print("User signed in: \(user.uid)")
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isProcessing = false
    }
}

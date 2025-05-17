import FirebaseAuth
import SwiftUI

@MainActor
class MockAuthenticationService: ObservableObject, AuthenticationServiceProtocol {
    @Published var currentUser: User? = nil
    
    func signUp(withEmail email: String, password: String, firstName: String, lastName: String) async throws -> FirebaseAuth.User {
        // Simulate success for previews
        print("[PREVIEW] Sign up with \(email)")
        
        // Since we can't create a real FirebaseAuth.User for preview, throw a controlled error
        let error = NSError(domain: "MockError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock sign up for preview"])
        throw error
    }
    
    func signIn(withEmail email: String, password: String) async throws -> FirebaseAuth.User {
        // Simulate success for previews
        print("[PREVIEW] Sign in with \(email)")
        
        // Since we can't create a real FirebaseAuth.User for preview, throw a controlled error
        let error = NSError(domain: "MockError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock sign in for preview"])
        throw error
    }
    
    func signOut() async throws {
        // No-op for preview
        print("[PREVIEW] Sign out")
    }
    
    static let previewMock = MockAuthenticationService()
}
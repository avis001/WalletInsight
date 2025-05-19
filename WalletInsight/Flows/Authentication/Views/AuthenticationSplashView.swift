//
//  AuthenticationSplashView.swift
//  WalletInsight
//
//  Created by Sivasankar on 19/5/25.
//

import SwiftUI
import DesignSystem

public struct AuthenticationSplashView: View {
    @State private var viewModel: AuthenticationViewModel
    @State private var isPresentingSignIn: Bool = false
    @State private var isPresentingSignUp: Bool = false
    private let hapticGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    init(authService: AuthenticationServiceProtocol) {
        _viewModel = State(initialValue: AuthenticationViewModel(authService: authService))
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Spacer()
            
            Group {
                Text("appName")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
                
                Text("splashScreenHookOne")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, Spacing.small)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Group {
                Button {
                    hapticGenerator.impactOccurred()
                    // Action for Apple Sign In
                } label: {
                    Spacer()
                    Text("\(LocalizedStringResource("continueWith"))  \(Image(systemName: "apple.logo"))")
                        .wiPrimaryButtonTextStyle()
                    Spacer()
                }
                .wiPrimaryButtonStyleModifier()
                .padding(.top, Spacing.xl)
                
                Button {
                    hapticGenerator.impactOccurred()
                    isPresentingSignIn = true
                } label: {
                    Spacer()
                    Text("continueWithOtherOptions")
                        .wiSecondaryButtonTextStyle()
                    Spacer()
                }
                .wiSecondaryButtonStyleModifier()
                .padding(.top, Spacing.medium)
                
                Button {
                    hapticGenerator.impactOccurred()
                    isPresentingSignUp = true
                } label: {
                    Spacer()
                    Text("signUpWithEmail")
                        .wiSecondaryButtonTextStyle()
                    Spacer()
                }
                .wiSecondaryButtonStyleModifier()
                .padding(.top, Spacing.medium)
            }
        }
        .padding(.leading, Spacing.medium)
        .padding(.trailing, Spacing.small)
        .sheet(isPresented: $isPresentingSignIn) {
            SignInFormView(viewModel: viewModel)
                .presentationBackground(.regularMaterial)
        }
        .sheet(isPresented: $isPresentingSignUp) {
            SignUpFormView(viewModel: viewModel)
                .presentationBackground(.regularMaterial)
        }
    }
}

#Preview {
    AuthenticationSplashView(authService: MockAuthenticationService.previewMock)
        .background(.backgroundMain)
}

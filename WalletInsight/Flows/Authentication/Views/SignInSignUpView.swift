//
//  SignInSignUpView.swift
//  TravelNanban
//
//  Created by Sivasankar on 23/2/25.
//

import SwiftUI
import DesignSystem

struct SignInSignUpView: View {
    @State private var viewModel: AuthenticationViewModel
    
    init(authService: AuthenticationServiceProtocol) {
        _viewModel = State(initialValue: AuthenticationViewModel(authService: authService))
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(viewModel.authPath == .signIn ? "welcomeBack" : "getStarted")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .foregroundStyle(Color.backgroundDark)
            
            Group {
                if viewModel.authPath == .signIn {
                    SignInFormView(viewModel: viewModel)
                        .transition(.move(edge: .leading))
                }
                else if viewModel.authPath == .signUp {
                    SignUpFormView(viewModel: viewModel)
                        .transition(.move(edge: .trailing))
                }
            }
            .padding(.horizontal)
            .padding(.top, Spacing.large)
            
            SignInSignUpTabBarView(viewModel: $viewModel)
                .padding(.top, Spacing.xxxl)
        }
        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .center)
        .animation(.default, value: viewModel.authPath)
    }
}

#Preview {
    SignInSignUpView(authService: MockAuthenticationService.previewMock)
}

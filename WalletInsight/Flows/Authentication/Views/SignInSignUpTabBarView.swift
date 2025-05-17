//
//  SignInSignUpTabBarView.swift
//  TravelNanban
//
//  Created by Sivasankar on 24/2/25.
//

import SwiftUI
import DesignSystem

struct SignInSignUpTabBarView: View {
    @Binding var viewModel: AuthenticationViewModel
    
    var body: some View {
        HStack(spacing: .zero) {
            Group {
                Button(action:  {
                    viewModel.updateAuthPath(.signIn)
                }, label: {
                    Text("signIn")
                        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .center)
                        .foregroundStyle(
                            viewModel.authPath == .signIn ? Color.surfaceDark : Color.secondary
                        )
                })
                .disabled(
                    viewModel.authPath == .signIn
                )
                .modifier(
                    AnimatableScaleEffect(
                        condition: viewModel.authPath == .signUp
                    )
                )
                
                Button(action:  {
                    viewModel.updateAuthPath(.signUp)
                }, label: {
                    Text("signUp")
                        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .center)
                        .foregroundStyle(
                            viewModel.authPath == .signUp ? Color.surfaceDark : Color.secondary
                        )
                })
                .disabled(
                    viewModel.authPath == .signUp
                )
                .modifier(
                    AnimatableScaleEffect(
                        condition: viewModel.authPath == .signIn
                    )
                )
            }
            .font(.title)
            .fontWeight(.medium)
            .padding(.top, Spacing.medium)
            .ignoresSafeArea()
            .frame(height: 60)
        }
        .animation(.interpolatingSpring(duration: 0.1), value: viewModel.authPath)
    }
}

#Preview {
    VStack {
        Spacer()
        SignInSignUpTabBarView(viewModel: .constant(AuthenticationViewModel(authService: MockAuthenticationService.previewMock)))
    }
}

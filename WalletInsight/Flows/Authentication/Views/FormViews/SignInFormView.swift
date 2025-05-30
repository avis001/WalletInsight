//
//  SignInFormView.swift
//  TravelNanban
//
//  Created by Sivasankar on 25/2/25.
//

import SwiftUI
import DesignSystem

private enum SelectedField {
    case email, password
}

struct SignInFormView: View {
    var viewModel: AuthenticationViewModel
    @FocusState private var selectedField: SelectedField?
    @State private var emailText: String = ""
    @State private var passwordText: String = ""
    @Environment(\.dismiss) private var dismiss
    private let hapticGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .center, spacing: Spacing.medium) {
                Group {
                    TextField(" \(Image(systemName: "envelope.fill")) \(String(localized: "email"))", text: $emailText)
                        .focused($selectedField, equals: SelectedField.email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                    SecureField(" \(Image(systemName: "lock.fill")) \(String(localized: "password"))", text: $passwordText)
                        .focused($selectedField, equals: SelectedField.password)
                        .textContentType(.password)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: CornerRadius.level3)
                        .fill(Color.primary.opacity(0.04))
                        .allowsHitTesting(false)
                )
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                            
                Button {
                    hapticGenerator.impactOccurred()
                    Task {
                        await viewModel.signIn(email: emailText, password: passwordText)
                    }
                } label: {
                    if viewModel.isProcessing {
                        ProgressView()
                            .padding()
                            .padding(.horizontal, Spacing.xl)
                    } else {
                        Text("continue")
                            .wiPrimaryButtonTextStyle()
                    }
                }
                .disabled(viewModel.isProcessing)
                .wiPrimaryButtonStyleModifier()
                
                AlternateSignInOptionsView()
            }
            .padding(.horizontal, Spacing.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        hapticGenerator.impactOccurred()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

#Preview {
    SignInFormView(viewModel: AuthenticationViewModel(authService: MockAuthenticationService.previewMock))
        .padding()
        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
        .background(.backgroundMain)
}

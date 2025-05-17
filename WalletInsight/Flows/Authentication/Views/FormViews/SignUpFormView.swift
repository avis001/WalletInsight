//
//  SignUpFormView.swift
//  TravelNanban
//
//  Created by Sivasankar on 25/2/25.
//

import SwiftUI
import DesignSystem

private enum SelectedField {
    case fName, lName, email, password, confirmPassword
}

struct SignUpFormView: View {
    var viewModel: AuthenticationViewModel
    @FocusState private var selectedField: SelectedField?
    @State private var fNameText: String = .empty
    @State private var lNameText: String = .empty
    @State private var emailText: String = .empty
    @State private var passwordText: String = .empty
    @State private var confirmPasswordText: String = .empty
    
    var body: some View {
        VStack (alignment: .center, spacing: Spacing.medium) {
            Group {
                TextField(" \(Image(systemName: "person.fill")) \(String(localized: "fName"))", text: $fNameText)
                    .focused($selectedField, equals: SelectedField.fName)
                    .hitTestablePadding()
                    .textContentType(.name)
                    .keyboardType(.alphabet)
                    .onTapGesture {
                        selectedField = .fName
                    }
                
                TextField(" \(Image(systemName: "person.fill")) \(String(localized: "lName"))", text: $lNameText)
                    .focused($selectedField, equals: SelectedField.lName)
                    .hitTestablePadding()
                    .textContentType(.familyName)
                    .keyboardType(.alphabet)
                    .onTapGesture {
                        selectedField = .lName
                    }
                
                TextField(" \(Image(systemName: "envelope.fill")) \(String(localized: "email"))", text: $emailText)
                    .focused($selectedField, equals: SelectedField.email)
                    .hitTestablePadding()
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .onTapGesture {
                        selectedField = .email
                    }
                
                SecureField(" \(Image(systemName: "lock.fill")) \(String(localized: "password"))", text: $passwordText)
                    .focused($selectedField, equals: SelectedField.password)
                    .hitTestablePadding()
                    .textContentType(.newPassword)
                    .onTapGesture {
                        selectedField = .password
                    }
                
                SecureField(" \(Image(systemName: "lock.fill")) \(String(localized: "confirmPassword"))", text: $confirmPasswordText)
                    .focused($selectedField, equals: SelectedField.confirmPassword)
                    .hitTestablePadding()
                    .textContentType(.newPassword)
                    .onTapGesture {
                        selectedField = .confirmPassword
                    }
            }
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
                Task {
                    await viewModel.signUp(
                        email: emailText,
                        password: passwordText,
                        firstName: fNameText,
                        lastName: lNameText
                    )
                }
            } label: {
                if viewModel.isProcessing {
                    ProgressView()
                        .padding()
                        .padding(.horizontal, Spacing.xl)
                } else {
                    Text("continue")
                        .padding()
                        .padding(.horizontal, Spacing.xl)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                }
            }
            .disabled(viewModel.isProcessing)
            .background(
                RoundedRectangle(cornerRadius: CornerRadius.level3)
                    .fill(Color.actionPrimary)
            )
        }.padding(.horizontal, 24)
    }
}

#Preview {
    SignUpFormView(viewModel: AuthenticationViewModel(authService: MockAuthenticationService.previewMock))
        .padding()
        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
        .background(.backgroundMain)
}

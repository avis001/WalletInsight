//
//  AuthenticationSplashView.swift
//  WalletInsight
//
//  Created by Sivasankar on 19/5/25.
//

import SwiftUI
import DesignSystem

public struct AuthenticationSplashView: View {
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
                    //
                } label: {
                    Spacer()
                    Text("\(LocalizedStringResource("continueWith"))  \(Image(systemName: "apple.logo"))")
                        .wiPrimaryButtonTextStyle()
                    Spacer()
                }
                .wiPrimaryButtonStyleModifier()
                .padding(.top, Spacing.xl)
                
                Button {
                    //
                } label: {
                    Spacer()
                    Text("continueWithOtherOptions")
                        .wiSecondaryButtonTextStyle()
                    Spacer()
                }
                .wiSecondaryButtonStyleModifier()
                .padding(.top, Spacing.medium)
                
                Button {
                    //
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
        .frame(maxWidth: .infinity)
        .padding(.leading, Spacing.medium)
        .padding(.trailing, Spacing.small)
    }
}

#Preview {
    AuthenticationSplashView()
        .background(.backgroundMain)
}

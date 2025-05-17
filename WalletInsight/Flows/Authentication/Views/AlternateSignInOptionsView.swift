//
//  AlternateSignInOptionsView.swift
//  TravelNanban
//
//  Created by Sivasankar on 25/2/25.
//

import SwiftUI
import DesignSystem

struct AlternateSignInOptionsView: View {
    var body: some View {
        VStack(spacing: .zero) {
            HStack(alignment: .center) {
                LineView()
                Text("orSignInUsing")
                    .fixedSize()
                LineView()
            }
            
            HStack {
                Group {
                    Button(action: {
                        //
                    }, label: {
                        ButtonLabel("\(Image(systemName: "apple.logo"))")
                    })
                    
                    Button(action: {
                        //
                    }, label: {
                        ButtonLabel("f")
                    })
                    
                    Button(action: {
                        //
                    }, label: {
                        ButtonLabel("G")
                    })
                }
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(Color.white)
                .background(Color.actionPrimary)
                .clipShape(RoundedRectangle(cornerRadius: CornerRadius.level1))
            }
            .padding(.top, Spacing.medium)
        }
    }
}

#Preview {
    AlternateSignInOptionsView()
        .padding()
        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
        .background(.backgroundMain)
}

// Pragma:- Private Support

private struct ButtonLabel: View {
    var text: LocalizedStringKey
    
    init(_ text: LocalizedStringKey) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .frame(width: 50, height: 50, alignment: .center)
            .padding(.horizontal)
    }
}

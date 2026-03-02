//
//  WelcomeScreenView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import SwiftUI

struct WelcomeScreenView: View {
    @Environment(SessionManager.self) private var session
    @Environment(DependencyContainer.self) private var container

    var body: some View {
        NavigationStack {
            VStack(spacing: Constants.Spacing.extraLarge) {
                welcomeHeader
                signUpSection
                signInSection
            }
            .padding(.horizontal, Constants.Padding.large)
            .padding(.top, Constants.Padding.extraLarge)
        }
    }
    
    @ViewBuilder private var welcomeHeader: some View {
        Image(systemName: Constants.Icons.listName)
            .resizable()
            .scaledToFit()
            .frame(height: Constants.Height.extraLarge)
        Text(Constants.Strings.welcomeMessage)
            .font(.system(size: Constants.Fonts.extraLarge))
            .multilineTextAlignment(.center)
    }
    
    private var signUpSection: some View {
        VStack {
            Text(Constants.Strings.newUser)
            NavigationLink(
                destination: RegistrationView(
                    viewModel: RegistrationViewModel(userUseCase: container.userUseCase, session: session)
                )
            ) {
                Text(Constants.Strings.signUp)
                    .foregroundStyle(Constants.Colors.primaryColor)
                    .underline()
            }
        }
    }
    
    private var signInSection: some View {
        VStack {
            Text(Constants.Strings.existingUser)
            NavigationLink(
                destination: LoginView(
                    viewModel: LoginViewModel(userUseCase: container.userUseCase, session: session)
                )
            ) {
                Text(Constants.Strings.signIn)
                    .foregroundStyle(Constants.Colors.primaryColor)
                    .underline()
            }
        }
    }
}

#Preview {
    WelcomeScreenView()
}

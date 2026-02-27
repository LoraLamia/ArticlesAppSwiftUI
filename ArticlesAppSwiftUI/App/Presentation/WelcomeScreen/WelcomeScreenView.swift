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
            VStack {
                welcomeHeader
                signUpSection
                signInSection
            }
            .padding(.horizontal, Constants.Padding.large)
        }
    }
    
    @ViewBuilder private var welcomeHeader: some View {
        Spacer()
        Image(systemName: Constants.Icons.listName)
            .resizable()
            .scaledToFit()
            .frame(height: Constants.Height.extraLarge)
        Spacer()
        Text(Constants.Strings.welcomeMessage)
            .font(.system(size: Constants.Fonts.extraLarge))
            .multilineTextAlignment(.center)
        Spacer()
    }
    
    @ViewBuilder private var signUpSection: some View {
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
        Spacer()
    }
    
    @ViewBuilder private var signInSection: some View {
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
        Spacer()
    }
}

#Preview {
    WelcomeScreenView()
}

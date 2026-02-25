//
//  WelcomeScreenView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import SwiftUI

struct WelcomeScreenView: View {
    @Environment(SessionManager.self) private var session
    let container: DependencyContainer

    var body: some View {
        NavigationStack {
            VStack {
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
                Text(Constants.Strings.newUser)
                NavigationLink(
                    destination: RegistrationView(
                        viewModel: RegistrationViewModel(userUseCase: container.userUseCase, session: session))) {
                    Text(Constants.Strings.signUp)
                        .foregroundStyle(Constants.Colors.primaryColor)
                        .underline()
                }
                Spacer()
                Text(Constants.Strings.existingUser)
                NavigationLink(destination: LoginView()) {
                    Text(Constants.Strings.signIn)
                        .foregroundStyle(Constants.Colors.primaryColor)
                        .underline()
                }
                Spacer()
            }
            .padding(.horizontal, Constants.Padding.large)
        }
    }
}

//#Preview {
//    WelcomeScreenView(container: DependencyContainer())
//}

//
//  RegistrationView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import SwiftUI

struct RegistrationView: View {
    @State var viewModel = RegistrationViewModel(userUseCase: UserUseCase(userRepository: UserRepository(remote: UserRemoteDataSource())))
    
    var body: some View {
        VStack(spacing: Constants.Spacing.large) {
            Text(Constants.Strings.createAccount)
                .font(.system(size: Constants.Fonts.extraLarge))

            VStack(spacing: Constants.Padding.normal) {
                InputField(
                    placeholder: Constants.Strings.usernamePlaceholder,
                    text: $viewModel.username
                )
                
                InputField(
                    placeholder: Constants.Strings.passwordPlaceholder,
                    text: $viewModel.password,
                    isSecure: true
                )
            }
            
            Button(action: {
                viewModel.register()
            }) {
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text(Constants.Strings.register)
                            .bold()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(Constants.Padding.normal)
                .background(Constants.Colors.primaryColor)
                .foregroundColor(Constants.Colors.buttonTextColor)
                .cornerRadius(Constants.CornerRadius.normal)
            }
            .disabled(viewModel.isLoading || viewModel.username.isEmpty || viewModel.password.isEmpty)
            .opacity((viewModel.isLoading || viewModel.username.isEmpty || viewModel.password.isEmpty) ? 0.6 : 1.0)
            Spacer()
        }
        .padding(.top, Constants.Padding.extraLarge)
        .padding(.horizontal, Constants.Padding.large)
        .alert(
            Constants.Strings.registrationFailed,
            isPresented: $viewModel.showErrorMessage
        ) {
            Button(Constants.Strings.ok, role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
}


#Preview {
    RegistrationView()
}

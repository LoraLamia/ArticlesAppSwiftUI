//
//  RegistrationView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import SwiftUI

struct RegistrationView: View {
    @State var viewModel: RegistrationViewModel
    @FocusState private var focusedField: Field?

    var body: some View {
        VStack(spacing: Constants.Spacing.large) {
            title
            inputFields
            registerButton
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
        .onAppear {
            focusedField = .username
        }
    }
    
    
    private var registerButton: some View {
        Button {
            viewModel.onRegisterTap()
        } label: {
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
            .foregroundStyle(Constants.Colors.buttonTextColor)
            .cornerRadius(Constants.CornerRadius.normal)
        }
        .disabled(viewModel.isRegistrationDisabled)
        .opacity(viewModel.isRegistrationDisabled ? 0.6 : 1.0)
    }
    
    private var inputFields: some View {
        VStack(spacing: Constants.Padding.normal) {
            InputField(
                placeholder: Constants.Strings.usernamePlaceholder,
                text: $viewModel.username,
                isFocused: focusedField == .username
            )
            .focused($focusedField, equals: .username)
            .submitLabel(.next)
            .onSubmit {
                focusedField = .password
            }
            
            InputField(
                placeholder: Constants.Strings.passwordPlaceholder,
                text: $viewModel.password,
                isSecure: true,
                isFocused: focusedField == .password
            )
            .focused($focusedField, equals: .password)
            .submitLabel(.done)
        }
    }
    
    private var title: some View {
        Text(Constants.Strings.createAccount)
            .font(.system(size: Constants.Fonts.extraLarge))
    }
}

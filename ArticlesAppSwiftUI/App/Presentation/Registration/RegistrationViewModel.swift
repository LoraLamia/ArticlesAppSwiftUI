//
//  RegistrationViewModel.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import SwiftUI
import Combine

@Observable
class RegistrationViewModel {
    private let userUseCase: UserUseCaseRegistration
    private var cancellables = Set<AnyCancellable>()
    var username = ""
    var password = ""
    var isLoading = false
    var errorMessage: String?
    var showErrorMessage = false

    init(userUseCase: UserUseCaseRegistration) {
        self.userUseCase = userUseCase
    }
    
    func register() {        
        isLoading = true
        errorMessage = nil
        
        userUseCase.register(username: username, password: password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                    self.showErrorMessage = true
                }
            } receiveValue: { _ in
                print("User registered successfully.")
            }
            .store(in: &cancellables)
    }
}


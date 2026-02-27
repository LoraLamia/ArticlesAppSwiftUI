//
//  LoginViewModel.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 26.02.2026..
//

import SwiftUI
import Combine

@Observable
class LoginViewModel {
    private let userUseCase: UserUseCaseLogin
    private let session: SessionManager
    
    private var cancellables = Set<AnyCancellable>()
    
    var username = ""
    var password = ""
    var isLoading = false
    var errorMessage: String?
    var showErrorMessage = false
    
    init(userUseCase: UserUseCaseLogin, session: SessionManager) {
        self.userUseCase = userUseCase
        self.session = session
    }
    
    func login() {
        isLoading = true
        errorMessage = nil
        
        userUseCase.login(username: username, password: password)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self else { return }
                    
                    if case .failure(let error) = completion {
                        self.errorMessage = error.localizedDescription
                        self.showErrorMessage = true
                    }
                    self.isLoading = false
                },
                receiveValue: { _ in }
            )
            .store(in: &cancellables)
    }
}


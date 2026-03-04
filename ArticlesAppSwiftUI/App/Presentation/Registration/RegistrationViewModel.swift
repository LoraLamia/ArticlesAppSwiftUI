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
    private let session: SessionManager
    private var analyticsService: AnalyticsService
    
    private var cancellables = Set<AnyCancellable>()
    var username = ""
    var password = ""
    var isLoading = false
    var errorMessage: String?
    var showErrorMessage = false
    
    var isRegistrationDisabled: Bool {
        isLoading || username.isEmpty || password.isEmpty
    }
    
    init(userUseCase: UserUseCaseRegistration, session: SessionManager, analyticsService: AnalyticsService) {
        self.userUseCase = userUseCase
        self.session = session
        self.analyticsService = analyticsService
    }
    
    func register() {
        isLoading = true
        errorMessage = nil
        
        userUseCase.register(username: username, password: password)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self else { return }
                    
                    if case .failure(let error) = completion {
                        self.errorMessage = error.localizedDescription
                        self.showErrorMessage = true
                        self.analyticsService.log(AuthEvent.registerFailure(reason: error.localizedDescription))
                    }
                    self.isLoading = false
                },
                receiveValue: { [weak self] _ in
                    guard let self else { return }
                    self.analyticsService.log(AuthEvent.registerSuccess)
                }
            )
            .store(in: &cancellables)
    }
}

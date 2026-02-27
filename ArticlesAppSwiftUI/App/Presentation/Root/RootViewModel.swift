//
//  RootViewModel.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 27.02.2026..
//

import Foundation
import Combine

@Observable
final class RootViewModel {
    
    private let userUseCase: UserUseCaseRoot
    private let session: SessionManager
    private var cancellables = Set<AnyCancellable>()
    
    var isChecking = true
    
    init(userUseCase: UserUseCaseRoot, session: SessionManager) {
        self.userUseCase = userUseCase
        self.session = session
        checkUser()
    }
    
    func checkUser() {
        
        guard let token = KeychainManager.getToken() else {
            isChecking = false
            return
        }
        
        userUseCase
            .getUser()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                
                if case .failure(let error) = completion {
                    if case DomainError.unauthorized = error {
                        self.session.logout()
                    }
                    self.isChecking = false
                }
                
            } receiveValue: { [weak self] _ in
                guard let self else { return }
                
                let userData = UserData(
                    username: "john doe",
                    accessToken: token
                )
                self.session.login(with: userData)
                self.isChecking = false
            }
            .store(in: &cancellables)
    }
}


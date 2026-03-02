//
//  UserUseCase.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import Combine
import SwiftUI

final class UserUseCase: UserUseCaseRegistration, UserUseCaseLogin {
    private var sessionManager: SessionManager
    private let userRepository: UserRepositoryContract
    
    init(userRepository: UserRepository, sessionManager: SessionManager) {
        self.userRepository = userRepository
        self.sessionManager = sessionManager
    }
    
    func register(username: String, password: String) -> AnyPublisher<Void, DomainError> {
        userRepository
            .registerUser(username: username, password: password)
            .handleEvents(receiveOutput: { [weak self] userData in
                guard let self else { return }
                self.sessionManager.login(with: userData)
            })
            .map { _ in }
            .eraseToAnyPublisher()
        
    }
    
    func login(username: String, password: String) -> AnyPublisher<Void, DomainError> {
        userRepository
            .loginUser(username: username, password: password)
            .handleEvents(receiveOutput: { [weak self] userData in
                guard let self else { return }
                self.sessionManager.login(with: userData)
            })
            .map { _ in }
            .eraseToAnyPublisher()
    }
}


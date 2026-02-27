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
    
    func register(username: String, password: String) -> AnyPublisher<Void, Error> {
        userRepository
            .registerUser(username: username, password: password)
            .handleEvents(receiveOutput: { userData in
                self.sessionManager.login(with: userData)
            })
            .map { _ in }
            .eraseToAnyPublisher()
        
    }
    
    func login(username: String, password: String) -> AnyPublisher<Void, Error> {
        userRepository
            .loginUser(username: username, password: password)
            .handleEvents(receiveOutput: { userData in
                self.sessionManager.login(with: userData)
            })
            .map { _ in }
            .eraseToAnyPublisher()
    }
}


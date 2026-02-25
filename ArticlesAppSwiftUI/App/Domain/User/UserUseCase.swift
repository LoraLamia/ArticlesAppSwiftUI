//
//  UserUseCase.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import Combine

final class UserUseCase: UserUseCaseRegistration {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func register(username: String, password: String) -> AnyPublisher<Void, Error> {
        userRepository.registerUser(username: username, password: password)
    }
}


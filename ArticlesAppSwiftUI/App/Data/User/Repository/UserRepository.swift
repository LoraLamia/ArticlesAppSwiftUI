//
//  UserRepository.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import Combine
import Alamofire

final class UserRepository: UserRepositoryContract {
    private let remote: UserRemoteDataSourceContract
    
    init(remote: UserRemoteDataSourceContract) {
        self.remote = remote
    }
        
    func registerUser(username: String, password: String) -> AnyPublisher<UserData, DomainError> {
        remote.registerUser(username: username, password: password)
            .map { UserData(username: "john doe", accessToken: $0.accessToken) }
            .mapError { error -> DomainError in
                return DomainError.network(error)
            }
            .eraseToAnyPublisher()
    }
    
    func loginUser(username: String, password: String) -> AnyPublisher<UserData, DomainError> {
        remote.loginUser(username: username, password: password)
            .map { UserData(username: "john doe", accessToken: $0.accessToken) }
            .mapError { error -> DomainError in
                return DomainError.network(error)
            }
            .eraseToAnyPublisher()
    }
}


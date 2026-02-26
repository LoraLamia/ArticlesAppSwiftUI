//
//  UserRepository.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import Combine

final class UserRepository: UserRepositoryContract {
    private let remote: UserRemoteDataSource
    
    init(remote: UserRemoteDataSource) {
        self.remote = remote
    }
    
    func registerUser(username: String, password: String) -> AnyPublisher<Void, Error> {
        remote.registerUser(username: username, password: password)
            .map { response in
                KeychainManager.save(token: response.accessToken)
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func loginUser(username: String, password: String) -> AnyPublisher<Void, Error> {
        remote.loginUser(username: username, password: password)
            .map { response in
                KeychainManager.save(token: response.accessToken)
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}


//
//  UserRepository.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import Combine

final class UserRepository: UserRepositoryContract {
    private let remote: UserRemoteDataSourceContract
    
    init(remote: UserRemoteDataSourceContract) {
        self.remote = remote
    }
    
    //get user funkcija koja zove getarticles
    
    func registerUser(username: String, password: String) -> AnyPublisher<UserData, Error> {
        remote.registerUser(username: username, password: password)
            .map { UserData(username: "john doe", accessToken: $0.accessToken) }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func loginUser(username: String, password: String) -> AnyPublisher<UserData, Error> {
        remote.loginUser(username: username, password: password)
            .map { UserData(username: "john doe", accessToken: $0.accessToken) }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}


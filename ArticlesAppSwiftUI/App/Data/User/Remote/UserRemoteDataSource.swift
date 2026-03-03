//
//  UserRemoteDataSource.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import Combine

final class UserRemoteDataSource: UserRemoteDataSourceContract {
    private let client: NetworkClientContract
    
    init(client: NetworkClientContract) {
        self.client = client
    }
    
    func registerUser(username: String, password: String) -> AnyPublisher<UserResponse, Error> {
        client.request(UserEndpoint.register(username: username, password: password), responseType: UserResponse.self)
    }
    
    func loginUser(username: String, password: String) -> AnyPublisher<UserResponse, Error> {
        client.request(UserEndpoint.login(username: username, password: password), responseType: UserResponse.self)
    }
}

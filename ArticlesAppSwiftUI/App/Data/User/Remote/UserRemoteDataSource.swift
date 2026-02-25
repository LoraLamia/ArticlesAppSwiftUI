//
//  UserRemoteDataSource.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import Combine
import Alamofire

final class UserRemoteDataSource {
    
    func registerUser(username: String, password: String) -> AnyPublisher<UserResponse, AFError> {
        return AF.request(
            Constants.API.baseURL + Constants.API.registerEndpoint,
            method: .post,
            parameters: ["username": username, "password": password]
        )
        .validate()
        .publishDecodable(type: UserResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
}

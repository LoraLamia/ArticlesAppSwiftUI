//
//  UserRemoteDataSourceContract.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 27.02.2026..
//

import Combine
import Alamofire

protocol UserRemoteDataSourceContract {
    func registerUser(username: String, password: String) -> AnyPublisher<UserResponse, AFError>
    func loginUser(username: String, password: String) -> AnyPublisher<UserResponse, AFError>
}


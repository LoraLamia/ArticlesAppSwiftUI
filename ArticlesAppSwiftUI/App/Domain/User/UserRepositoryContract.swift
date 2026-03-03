//
//  UserRepositoryContract.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import Combine

protocol UserRepositoryContract {
    func registerUser(username: String, password: String) -> AnyPublisher<UserData, DomainError>
    func loginUser(username: String, password: String) -> AnyPublisher<UserData, DomainError>
}

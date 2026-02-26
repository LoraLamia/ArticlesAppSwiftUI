//
//  UserUseCaseLogin.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 26.02.2026..
//

import Combine

protocol UserUseCaseLogin {
    func login(username: String, password: String) -> AnyPublisher<Void, Error>
}


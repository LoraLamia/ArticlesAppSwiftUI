//
//  UserUseCaseRegistration.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import Combine

protocol UserUseCaseRegistration {
    func register(username: String, password: String) -> AnyPublisher<Void, DomainError>
}


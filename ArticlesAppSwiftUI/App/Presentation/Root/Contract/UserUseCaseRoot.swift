//
//  UserUseCaseRoot.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 27.02.2026..
//

import Combine

protocol UserUseCaseRoot {
    func getUser() -> AnyPublisher<[Article], DomainError>
}


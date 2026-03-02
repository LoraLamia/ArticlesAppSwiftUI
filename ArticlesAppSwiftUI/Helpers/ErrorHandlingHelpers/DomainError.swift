//
//  DomainError.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 02.03.2026..
//

enum DomainError: Error {
    case unauthorized
    case network(Error)
    case notFound
}

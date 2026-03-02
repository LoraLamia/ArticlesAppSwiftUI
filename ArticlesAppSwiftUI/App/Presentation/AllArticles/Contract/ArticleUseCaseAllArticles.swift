//
//  ArticleUseCaseAllArticles.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine

protocol ArticleUseCaseAllArticles {
    func getArticles(page: Int) -> AnyPublisher<[Article], DomainError>
    func getTopics() -> AnyPublisher<[String], DomainError>
    func getFavoriteIDs() -> AnyPublisher<[String], Never>
    func toggleFavorite(articleId: String) -> AnyPublisher<Bool, Never>
}



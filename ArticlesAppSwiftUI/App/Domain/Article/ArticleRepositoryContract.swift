//
//  ArticleRepositoryContract.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine

protocol ArticleRepositoryContract {
    // MARK: Remote
    func fetchArticles(page: Int) -> AnyPublisher<[Article], DomainError>
    func fetchTopics() -> AnyPublisher<[String], DomainError>
    func fetchArticle(id: String) -> AnyPublisher<[Article], DomainError>
    
    // MARK: Local
    func toggleFavorite(articleId: String) -> AnyPublisher<Bool, Never>
    func getFavoriteIDs() -> AnyPublisher<[String], Never>
}


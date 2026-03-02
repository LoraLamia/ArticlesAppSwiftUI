//
//  ArticleUseCase.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine

final class ArticleUseCase: ArticleUseCaseAllArticles, ArticleUseCaseFavorites, UserUseCaseRoot {
    private let repository: ArticleRepositoryContract
    
    init(repository: ArticleRepositoryContract) {
        self.repository = repository
    }
    
    // MARK: Remote
    
    func getArticles(page: Int) -> AnyPublisher<[Article], DomainError> {
        repository.fetchArticles(page: page)
    }
    
    func getTopics() -> AnyPublisher<[String], DomainError> {
        repository.fetchTopics()
    }
    
    func getUser() -> AnyPublisher<[Article], DomainError> {
        repository.fetchArticles(page: 1)
    }
    
    func getArticle(id: String) -> AnyPublisher<Article, DomainError> {
        repository.fetchArticle(id: id)
            .compactMap { $0.first }
            .eraseToAnyPublisher()
    }
    
    // MARK: Local

    func toggleFavorite(articleId: String) -> AnyPublisher<Bool, Never> {
        repository.toggleFavorite(articleId: articleId)
    }
    
    func getFavoriteIDs() -> AnyPublisher<[String], Never> {
        repository.getFavoriteIDs()
    }
}

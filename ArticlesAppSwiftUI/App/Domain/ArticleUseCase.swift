//
//  ArticleUseCase.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine

final class ArticleUseCase: ArticleUseCaseAllArticles, ArticleUseCaseFavorites {
    private let repository: ArticleRepositoryContract
    
    init(repository: ArticleRepositoryContract) {
        self.repository = repository
    }
    
    // MARK: Remote
    
    func getArticles(page: Int) -> AnyPublisher<[Article], Error> {
        repository.fetchArticles(page: page)
    }
    
    func getTopics() -> AnyPublisher<[String], Error> {
        repository.fetchTopics()
    }
    
    // MARK: Local

    func toggleFavorite(article: Article) -> AnyPublisher<Bool, Never> {
        repository.toggleFavorite(article: article)
    }
    
    func getFavorites() -> AnyPublisher<[Article], Never> {
        repository.loadFavorites()
    }
    
    func isFavorite(article: Article) -> AnyPublisher<Bool, Never> {
        repository.isFavorite(article: article)
    }
}

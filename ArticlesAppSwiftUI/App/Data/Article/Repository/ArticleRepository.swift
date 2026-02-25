//
//  ArticleRepository.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine

final class ArticleRepository: ArticleRepositoryContract {
    private let remote: RemoteDataSource
    private let local: LocalDataSource
    
    
    init(remote: RemoteDataSource, local: LocalDataSource) {
        self.remote = remote
        self.local = local
    }
    
    // MARK: Remote
    
    func fetchArticles(page: Int) -> AnyPublisher<[Article], Error> {
        remote.fetchArticles(page: page)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func fetchTopics() -> AnyPublisher<[String], Error> {
        remote.fetchTopics()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    // MARK: Local
    
    func toggleFavorite(article: Article) -> AnyPublisher<Bool, Never> {
        local.toggleFavorite(article: article)
    }
    
    func isFavorite(article: Article) -> AnyPublisher<Bool, Never> {
        local.isFavorite(article: article)
    }
    
    func loadFavorites() -> AnyPublisher<[Article], Never> {
        local.loadFavorites()
    }
}

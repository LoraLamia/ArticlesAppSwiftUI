//
//  ArticleRepository.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine
import Alamofire

final class ArticleRepository: ArticleRepositoryContract {
    private let remote: ArticleRemoteDataSource
    private let local: ArticleLocalDataSource
    
    init(remote: ArticleRemoteDataSource, local: ArticleLocalDataSource) {
        self.remote = remote
        self.local = local
    }
    
    // MARK: Remote
    
    func fetchArticles(page: Int) -> AnyPublisher<[Article], Error> {
        remote.fetchArticles(page: page)
            .mapError { error -> Error in
                if error.responseCode == 401 {
                    return DomainError.unauthorized
                }
                return DomainError.network(error)
            }
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
    
    func loadFavorites() -> AnyPublisher<[Article], Never> {
        local.loadFavorites()
    }
}

enum DomainError: Error {
    case unauthorized
    case network(Error)
}

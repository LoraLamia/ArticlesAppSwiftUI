//
//  ArticleRepository.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine
import Alamofire

final class ArticleRepository: ArticleRepositoryContract {
    private let remote: ArticleDataSourceContract
    private let local: FavoriteArticlesDataSource
    
    init(remote: ArticleDataSourceContract, local: FavoriteArticlesDataSource) {
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
    
    func fetchArticle(id: String) -> AnyPublisher<[Article], Error> {
        remote.fetchArticle(id: id)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    // MARK: Local
    
    func toggleFavorite(articleId: String) -> AnyPublisher<Bool, Never> {
        local.toggleFavorite(articleId: articleId)
    }
    
    func loadFavoriteIDs() -> AnyPublisher<[String], Never> {
        local.loadFavorites()
            .eraseToAnyPublisher()

    }
}

enum DomainError: Error {
    case unauthorized
    case network(Error)
    case notFound
}

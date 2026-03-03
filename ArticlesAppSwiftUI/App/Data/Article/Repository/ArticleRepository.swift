//
//  ArticleRepository.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine
import Foundation

final class ArticleRepository: ArticleRepositoryContract {
    private let articlesDataSource: ArticlesDataSourceContract
    private let favoritesDataSource: FavoritesDataSourceContract
    
    init(articlesDataSource: ArticlesDataSourceContract, favoritesDataSource: FavoritesDataSourceContract) {
        self.articlesDataSource = articlesDataSource
        self.favoritesDataSource = favoritesDataSource
    }
    
    // MARK: Remote
    
    func fetchArticles(page: Int) -> AnyPublisher<[Article], DomainError> {
        articlesDataSource.fetchArticles(page: page)
            .mapError { error -> DomainError in
                let nsError = error as NSError
                
                if nsError.code == 401 {
                    return .unauthorized
                }
                return DomainError.network(error)
            }
            .eraseToAnyPublisher()
    }
    
    func fetchTopics() -> AnyPublisher<[String], DomainError> {
        articlesDataSource.fetchTopics()
            .mapError { error -> DomainError in
                let nsError = error as NSError
                
                if nsError.code == 401 {
                    return .unauthorized
                }
                return DomainError.network(error)
            }
            .eraseToAnyPublisher()
    }
    
    func fetchArticle(id: String) -> AnyPublisher<[Article], DomainError> {
        articlesDataSource.fetchArticle(id: id)
            .mapError { error -> DomainError in
                let nsError = error as NSError
                
                if nsError.code == 401 {
                    return .unauthorized
                }
                return DomainError.network(error)
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: Local
    
    func toggleFavorite(articleId: String) -> AnyPublisher<Bool, Never> {
        favoritesDataSource.toggleFavorite(articleId: articleId)
    }
    
    func getFavoriteIDs() -> AnyPublisher<[String], Never> {
        favoritesDataSource.getFavorites()
            .eraseToAnyPublisher()

    }
}

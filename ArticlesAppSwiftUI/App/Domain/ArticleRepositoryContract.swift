//
//  ArticleRepositoryContract.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine

protocol ArticleRepositoryContract {
    // MARK: Remote
    func fetchArticles(page: Int) -> AnyPublisher<[Article], Error>
    func fetchTopics() -> AnyPublisher<[String], Error>
    
    // MARK: Local
    func toggleFavorite(article: Article) -> AnyPublisher<Bool, Never>
    func isFavorite(article: Article) -> AnyPublisher<Bool, Never>
    func loadFavorites() -> AnyPublisher<[Article], Never>
}


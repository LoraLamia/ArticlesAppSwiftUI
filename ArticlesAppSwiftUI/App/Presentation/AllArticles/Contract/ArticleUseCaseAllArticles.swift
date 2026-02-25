//
//  ArticleUseCaseAllArticles.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine

protocol ArticleUseCaseAllArticles {
    func getArticles(page: Int) -> AnyPublisher<[Article], Error>
    func getTopics() -> AnyPublisher<[String], Error>
    func getFavorites() -> AnyPublisher<[Article], Never>
    func toggleFavorite(article: Article) -> AnyPublisher<Bool, Never>
}



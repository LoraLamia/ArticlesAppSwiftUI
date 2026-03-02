//
//  ArticleUseCaseFavorites.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine

protocol ArticleUseCaseFavorites {
    func getFavoriteIDs() -> AnyPublisher<[String], Never>
    func toggleFavorite(articleId: String) -> AnyPublisher<Bool, Never>
    func getArticle(id: String) -> AnyPublisher<Article, DomainError>
}


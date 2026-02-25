//
//  ArticleUseCaseFavorites.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine

protocol ArticleUseCaseFavorites {
    func getFavorites() -> AnyPublisher<[Article], Never>
    func toggleFavorite(article: Article) -> AnyPublisher<Bool, Never>
}


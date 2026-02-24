//
//  ArticleUseCaseFavorites.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

protocol ArticleUseCaseFavorites {
    func getFavorites() -> [Article]
    func toggleFavorite(article: Article)
}


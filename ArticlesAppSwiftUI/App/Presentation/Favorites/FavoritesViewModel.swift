//
//  FavoritesViewModel.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine
import SwiftUI

@Observable
class FavoritesViewModel {
    private let articleUseCase: ArticleUseCaseFavorites
    
    var articles: [Article] = []
    
    init(articleUseCase: ArticleUseCaseFavorites) {
        self.articleUseCase = articleUseCase
    }
    
    func loadArticles() {
        articles = articleUseCase.getFavorites()
    }
    
    func toggleFavorite(article: Article) {
        articleUseCase.toggleFavorite(article: article)
        loadArticles()
    }
}


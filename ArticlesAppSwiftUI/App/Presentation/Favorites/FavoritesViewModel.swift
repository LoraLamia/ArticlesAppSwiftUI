//
//  FavoritesViewModel.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine

class FavoritesViewModel: ObservableObject {
    private let articleUseCase: ArticleUseCaseFavorites
    
    @Published var articles: [Article] = []
    
    private let service = ArticleService()
    
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


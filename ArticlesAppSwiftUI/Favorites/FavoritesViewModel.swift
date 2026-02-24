//
//  FavoritesViewModel.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine

class FavoritesViewModel: ObservableObject {
    @Published var articles: [Article] = []
    
    private let service = ArticleService()
    
    func loadArticles() {
        service.fetchArticles(page: 1) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let articles):
                self.articles = articles
            default:
                break
            }
        }
    }
}


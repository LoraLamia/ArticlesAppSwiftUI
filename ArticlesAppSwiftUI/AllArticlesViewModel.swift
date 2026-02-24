//
//  AllArticlesViewModel.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine
import Foundation

@MainActor
class ArticlesViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText: String = ""
    
    private let service = ArticleService()
    
    var filteredArticles: [Article] {
        if searchText.isEmpty {
            return articles
        } else {
            return articles.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.author.localizedCaseInsensitiveContains(searchText) ||
                $0.summary.localizedCaseInsensitiveContains(searchText) ||
                $0.topic.localizedCaseInsensitiveContains(searchText) ||
                $0.tags.contains {
                    $0.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
    }
    
    func loadArticles() {
        isLoading = true
        service.fetchArticles(page: 1) { [weak self] result in
            guard let self else { return }
            self.isLoading = false
            switch result {
            case .success(let articles):
                self.articles = articles
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}


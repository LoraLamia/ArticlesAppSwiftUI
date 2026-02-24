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
    @Published var articles: [ArticleAPI] = []
    @Published var topics: [String] = []
    @Published var selectedTopic: String?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText: String = ""
    @Published var isAscending: Bool = false
    
    private let service = ArticleService()
    
    var filteredArticles: [ArticleAPI] {
        let topicFiltered = selectedTopic == nil ? articles : articles.filter { $0.topic == selectedTopic }
        
        let searchFiltered: [ArticleAPI]
        
        if searchText.isEmpty {
            searchFiltered = topicFiltered
        } else {
            searchFiltered = topicFiltered.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.author.localizedCaseInsensitiveContains(searchText) ||
                $0.summary.localizedCaseInsensitiveContains(searchText) ||
                $0.topic.localizedCaseInsensitiveContains(searchText) ||
                $0.tags.contains {
                    $0.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
        
        return searchFiltered.sorted {
            isAscending
            ? $0.publishedAt < $1.publishedAt
            : $0.publishedAt > $1.publishedAt
        }
    }
    
    func toggleTopic(_ topic: String) {
        if selectedTopic == topic {
            selectedTopic = nil
        } else {
            selectedTopic = topic
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
    
    func loadTopics() {
        isLoading = true
        service.fetchTopics { [weak self] result in
            guard let self else { return }
            self.isLoading = false
            switch result {
            case .success(let topics):
                self.topics = topics
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}


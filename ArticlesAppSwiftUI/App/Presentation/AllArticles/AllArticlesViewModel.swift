//
//  AllArticlesViewModel.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine
import Foundation

@Observable
class AllArticlesViewModel {
    private let articleUseCase: ArticleUseCaseAllArticles
    private var cancellables = Set<AnyCancellable>()
    
    var articles: [Article] = []
    var topics: [String] = []
    var selectedTopic: String?
    var isLoading = false
    var errorMessage: String?
    var searchText: String = ""
    var isAscending: Bool = false
    
    var filteredArticles: [Article] {
        let topicFiltered = selectedTopic == nil ? articles : articles.filter { $0.topic == selectedTopic }
        
        let searchFiltered: [Article]
        
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
    
    init(articleUseCase: ArticleUseCaseAllArticles) {
        self.articleUseCase = articleUseCase
    }
    
    func isFavorite(_ article: Article) -> Bool {
        articleUseCase.isFavorite(article: article)
    }
    
    func toggleFavorite(_ article: Article) {
        articleUseCase.toggleFavorite(article: article)
//        objectWillChange.send() // ručno refresh jer favorites nisu @Published
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
        errorMessage = nil
        
        articleUseCase.getArticles(page: 1)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] articles in
                self?.articles = articles
            }
            .store(in: &cancellables)
    }
    
    func loadTopics() {
        isLoading = true
        errorMessage = nil
        
        articleUseCase.getTopics()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] topics in
                self?.topics = topics
            }
            .store(in: &cancellables)
    }
}


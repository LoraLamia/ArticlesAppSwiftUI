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
    var favoriteIDs: Set<String> = []
    
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
        bind()
    }
    
    func isFavorite(_ article: Article) -> Bool {
        favoriteIDs.contains(article.id)
    }
    
    func toggleFavorite(article: Article) {
        articleUseCase
            .toggleFavorite(article: article)
            .sink { _ in }
            .store(in: &cancellables)
    }
    
    func toggleTopic(_ topic: String) {
        if selectedTopic == topic {
            selectedTopic = nil
        } else {
            selectedTopic = topic
        }
    }
    
    private func bind() {
        getArticles()
        getTopics()
        getFavorites()
    }
    
    func getArticles() {
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
    
    func getTopics() {
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
    
    func getFavorites() {
        articleUseCase
            .getFavorites()
            .map { Set($0.map { $0.id }) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] ids in
                self?.favoriteIDs = ids
            }
            .store(in: &cancellables)
    }
}


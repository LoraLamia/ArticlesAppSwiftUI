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
    private let session: SessionManager
    private let isFavoritesEnabled: Bool
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
    
    init(articleUseCase: ArticleUseCaseAllArticles, session: SessionManager, isFavoritesEnabled: Bool) {
        self.articleUseCase = articleUseCase
        self.session = session
        self.isFavoritesEnabled = isFavoritesEnabled
        bind()
    }
    
    func isFavorite(_ article: Article) -> Bool {
        guard isFavoritesEnabled else { return false }

        return favoriteIDs.contains(article.id)
    }
    
    func toggleFavorite(article: Article) {
        guard isFavoritesEnabled else { return }

        articleUseCase
            .toggleFavorite(articleId: article.id)
            .receive(on: DispatchQueue.main)
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
        topicsAndArticlesCombined()
        getFavorites()
    }
    
    private func topicsAndArticlesCombined() {
        isLoading = true
        errorMessage = nil
        
        articleUseCase.getArticles(page: 1)
            .combineLatest(articleUseCase.getTopics())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                
                if case .failure(let error) = completion {
                    if case DomainError.unauthorized = error {
                        session.logout()
                    } else {
                        self.errorMessage = error.localizedDescription
                    }
                }
                self.isLoading = false
            } receiveValue: { [weak self] (articles, topics) in
                guard let self else { return }
                self.articles = articles
                self.topics = topics
            }
            .store(in: &cancellables)
    }
    
    func getFavorites() {
        guard isFavoritesEnabled else { return }

        articleUseCase
            .getFavoriteIDs()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] ids in
                self?.favoriteIDs = Set(ids)
            }
            .store(in: &cancellables)
    }
}


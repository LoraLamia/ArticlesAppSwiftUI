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
    private var cancellables = Set<AnyCancellable>()
    
    var articles: [Article] = []
    
    init(articleUseCase: ArticleUseCaseFavorites) {
        self.articleUseCase = articleUseCase
        bind()
    }
    
    func bind() {
        articleUseCase
            .getFavorites()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] favorites in
                self?.articles = favorites
            }
            .store(in: &cancellables)
    }
    
    func toggleFavorite(article: Article) {
        articleUseCase
            .toggleFavorite(article: article)
            .sink { _ in }
            .store(in: &cancellables)
    }
}


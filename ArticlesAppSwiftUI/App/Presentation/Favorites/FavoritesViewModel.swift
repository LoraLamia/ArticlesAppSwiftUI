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
    
    func toggleFavorite(article: Article) {
        articleUseCase
            .toggleFavorite(articleId: article.id)
            .sink { _ in }
            .store(in: &cancellables)
    }
    
    func bind() {
        articleUseCase
            .getFavoriteIDs()
            .flatMap { [weak self] ids -> AnyPublisher<[Article], Never> in
                guard let self = self else {
                    return Just([]).eraseToAnyPublisher()
                }
                                
                guard !ids.isEmpty else {
                    return Just([]).eraseToAnyPublisher()
                }
                
                let publishers = ids.map { id in
                    self.articleUseCase
                        .getArticle(id: id)
                        .catch { error -> Empty<Article, Never> in
                            return Empty()
                        }
                }
                
                return Publishers.MergeMany(publishers)
                    .collect()
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] articles in
                self?.articles = articles
            }
            .store(in: &cancellables)
    }
}


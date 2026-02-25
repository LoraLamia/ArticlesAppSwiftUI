//
//  ArticleLocalDataSource.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine
import Foundation

final class ArticleLocalDataSource {
    private let favoritesKey = Constants.UserDefaults.favoritesKey
    private let favoritesSubject: CurrentValueSubject<[Article], Never>
    
    init() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let decoded = try? JSONDecoder().decode([Article].self, from: data) {
            favoritesSubject = CurrentValueSubject(decoded)
        } else {
            favoritesSubject = CurrentValueSubject([])
        }
    }

    func toggleFavorite(article: Article) -> AnyPublisher<Bool, Never> {
        var current = favoritesSubject.value
        
        let isNowFavorite: Bool
        
        if let index = current.firstIndex(where: { $0.id == article.id }) {
            current.remove(at: index)
            isNowFavorite = false
        } else {
            current.append(article)
            isNowFavorite = true
        }
        
        // persist
        if let encoded = try? JSONEncoder().encode(current) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
        
        // emit new state
        favoritesSubject.send(current)
        
        return Just(isNowFavorite)
            .eraseToAnyPublisher()
    }
    
    func loadFavorites() -> AnyPublisher<[Article], Never> {
        favoritesSubject
            .eraseToAnyPublisher()
    }
}



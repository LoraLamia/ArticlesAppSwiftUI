//
//  FavoritesDataSource.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine
import Foundation

final class FavoritesDataSource: FavoritesDataSourceContract {
    private let favoritesKey = Constants.UserDefaults.favoritesKey
    private let favoritesSubject: CurrentValueSubject<[String], Never>
    
    init() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let decoded = try? JSONDecoder().decode([String].self, from: data) {
            favoritesSubject = CurrentValueSubject(decoded)
        } else {
            favoritesSubject = CurrentValueSubject([])
        }
    }

    func toggleFavorite(articleId: String) -> AnyPublisher<Bool, Never> {
        var current = favoritesSubject.value
        
        let isNowFavorite: Bool
        
        if let index = current.firstIndex(of: articleId) {
            current.remove(at: index)
            isNowFavorite = false
        } else {
            current.append(articleId)
            isNowFavorite = true
        }
        
        if let encoded = try? JSONEncoder().encode(current) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
        
        favoritesSubject.send(current)
        
        return Just(isNowFavorite)
            .eraseToAnyPublisher()
    }
    
    func getFavorites() -> AnyPublisher<[String], Never> {
        favoritesSubject
            .eraseToAnyPublisher()
    }
}



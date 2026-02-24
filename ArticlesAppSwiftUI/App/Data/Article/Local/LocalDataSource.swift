//
//  LocalDataSource.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Combine
import Foundation

final class LocalDataSource {
    private let favoritesKey = Constants.Keys.favoritesKey

    func toggleFavorite(article: Article) {
        var current = loadFavorites()
        
        if let index = current.firstIndex(where: { $0.id == article.id }) {
            current.remove(at: index)
        } else {
            current.append(article)
        }
        
        saveFavorites(current)
    }
    
    func loadFavorites() -> [Article] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else {
            return []
        }
        
        do {
            return try JSONDecoder().decode([Article].self, from: data)
        } catch {
            print("Failed to decode favorites:", error)
            return []
        }
    }
    
    private func saveFavorites(_ articles: [Article]) {
        do {
            let data = try JSONEncoder().encode(articles)
            UserDefaults.standard.set(data, forKey: favoritesKey)
        } catch {
            print("Failed to encode favorites:", error)
        }
    }
    
    func isFavorite(article: Article) -> Bool {
        loadFavorites().contains(where: { $0.id == article.id })
    }
}



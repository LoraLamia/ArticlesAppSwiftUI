//
//  FavoritesManager.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Foundation
import Combine

@MainActor
final class FavoritesManager: ObservableObject {
    
    static let shared = FavoritesManager()
    
    @Published private(set) var favoriteIDs: Set<String> = []
    
    private let key = "favorite_articles"
    
    private init() {
        loadFromUserDefaults()
    }
        
    func toggle(article: Article) {
        if favoriteIDs.contains(article.id) {
            favoriteIDs.remove(article.id)
        } else {
            favoriteIDs.insert(article.id)
        }
        saveToUserDefaults()
    }
    
    func isFavorite(_ article: Article) -> Bool {
        favoriteIDs.contains(article.id)
    }
        
    private func saveToUserDefaults() {
        UserDefaults.standard.set(Array(favoriteIDs), forKey: key)
    }
    
    private func loadFromUserDefaults() {
        if let saved = UserDefaults.standard.array(forKey: key) as? [String] {
            favoriteIDs = Set(saved)
        }
    }
}

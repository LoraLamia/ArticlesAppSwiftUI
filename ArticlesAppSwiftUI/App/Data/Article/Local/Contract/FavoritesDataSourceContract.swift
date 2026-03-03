//
//  FavoritesDataSourceContract.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 02.03.2026..
//

import Combine

protocol FavoritesDataSourceContract {
    func toggleFavorite(articleId: String) -> AnyPublisher<Bool, Never>
    func getFavorites() -> AnyPublisher<[String], Never>
}


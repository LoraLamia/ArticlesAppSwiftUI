//
//  DependencyContainer.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

@Observable
final class DependencyContainer {
    private let networkClient: NetworkClientContract

    // Article
    private let articlesDataSource: ArticlesDataSource
    private let favoritesDataSource: FavoritesDataSource
    
    let articleRepository: ArticleRepository
    let articleUseCase: ArticleUseCase
    
    // User
    private let userRemote: UserRemoteDataSource
    
    let userRepository: UserRepository
    let userUseCase: UserUseCase
    
    
    init(sessionManager: SessionManager) {
        self.networkClient = NetworkClient()
        // Article
        self.articlesDataSource = ArticlesDataSource(client: networkClient)
        
        self.favoritesDataSource = FavoritesDataSource()
        
        self.articleRepository = ArticleRepository(
            articlesDataSource: articlesDataSource,
            favoritesDataSource: favoritesDataSource
        )
        
        self.articleUseCase = ArticleUseCase(
            repository: articleRepository
        )
        
        // User
        self.userRemote = UserRemoteDataSource(client: networkClient)
        
        self.userRepository = UserRepository(
            remote: userRemote
        )
        
        self.userUseCase = UserUseCase(
            userRepository: userRepository,
            sessionManager: sessionManager
        )
    }
}

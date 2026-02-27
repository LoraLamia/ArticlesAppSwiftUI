//
//  DependencyContainer.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

@Observable
final class DependencyContainer {
    // Article
    private let remote: ArticleDataSource
    private let local: FavoriteArticlesDataSource
    
    let articleRepository: ArticleRepository
    let articleUseCase: ArticleUseCase
    
    // User
    private let userRemote: UserRemoteDataSource
    
    let userRepository: UserRepository
    let userUseCase: UserUseCase
    
    
    init(sessionManager: SessionManager) {
        // Article
        self.remote = ArticleDataSource()
        
        self.local = FavoriteArticlesDataSource()
        
        self.articleRepository = ArticleRepository(
            remote: remote,
            local: local
        )
        
        self.articleUseCase = ArticleUseCase(
            repository: articleRepository
        )
        
        // User
        self.userRemote = UserRemoteDataSource()
        
        self.userRepository = UserRepository(
            remote: userRemote
        )
        
        self.userUseCase = UserUseCase(
            userRepository: userRepository,
            sessionManager: sessionManager
        )
    }
}

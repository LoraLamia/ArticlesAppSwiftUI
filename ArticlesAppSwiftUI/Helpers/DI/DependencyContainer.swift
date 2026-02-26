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
    private let remote: ArticleRemoteDataSource
    private let local: ArticleLocalDataSource
    
    let articleRepository: ArticleRepository
    let articleUseCase: ArticleUseCase
    
    // User
    private let userRemote: UserRemoteDataSource
    
    let userRepository: UserRepository
    let userUseCase: UserUseCase
    
    
    init() {
        // Article
        self.remote = ArticleRemoteDataSource()
        
        self.local = ArticleLocalDataSource()
        
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
            userRepository: userRepository
        )
    }
}

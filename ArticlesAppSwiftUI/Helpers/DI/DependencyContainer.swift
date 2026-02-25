//
//  DependencyContainer.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

final class DependencyContainer {
    private let sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    // Article
    private lazy var remote = ArticleRemoteDataSource(
        onUnauthorized: { [weak sessionManager] in
            sessionManager?.logout()
        }
    )
    private let local = ArticleLocalDataSource()
    
    lazy var articleRepository = ArticleRepository(remote: remote, local: local)
    lazy var articleUseCase = ArticleUseCase(repository: articleRepository)
    
    // User
    private let userRemote = UserRemoteDataSource()
    
    lazy var userRepository = UserRepository(remote: userRemote)
    lazy var userUseCase = UserUseCase(userRepository: userRepository)
}


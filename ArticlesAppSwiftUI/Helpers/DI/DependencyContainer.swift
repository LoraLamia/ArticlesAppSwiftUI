//
//  DependencyContainer.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

final class DependencyContainer {
    
    // Data sources
    private let remote = RemoteDataSource()
    private let local = LocalDataSource()
    
    // Repository
    lazy var articleRepository = ArticleRepository(remote: remote, local: local)
    
    // Use cases
    lazy var articleUseCase = ArticleUseCase(repository: articleRepository)
}


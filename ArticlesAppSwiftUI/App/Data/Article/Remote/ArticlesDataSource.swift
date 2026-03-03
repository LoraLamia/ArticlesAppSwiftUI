//
//  ArticlesDataSource.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Foundation
import Combine

final class ArticlesDataSource: ArticlesDataSourceContract {
    private let client: NetworkClientContract
    
    init(client: NetworkClientContract) {
        self.client = client
    }

    func fetchArticles(page: Int) -> AnyPublisher<[Article], Error> {
        client.request(ArticlesEndpoint.articles(page: page), responseType: ArticlesResponse.self)
            .map { $0.articles.data }
            .eraseToAnyPublisher()
    }
    
    func fetchTopics() -> AnyPublisher<[String], Error> {
        client.request(ArticlesEndpoint.topics, responseType: [String].self)
    }
    
    func fetchArticle(id: String) -> AnyPublisher<[Article], Error> {
        client.request(ArticlesEndpoint.article(id: id), responseType: [Article].self)
    }
}


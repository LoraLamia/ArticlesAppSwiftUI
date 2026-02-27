//
//  ArticleDataSource.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Foundation
import Alamofire
import Combine

final class ArticleDataSource: ArticleDataSourceContract {
    func fetchArticles(page: Int) -> AnyPublisher<[Article], AFError> {
        let endpoint = ArticlesEndpoint.articles(page: page)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return AF.request(
            Constants.API.baseURL + endpoint.path,
            method: endpoint.method,
            parameters: endpoint.parameters,
            headers: endpoint.headers
        )
        .validate()
        .publishDecodable(type: ArticlesResponse.self, decoder: decoder)
        .value()
        .map { $0.articles.data }
        .eraseToAnyPublisher()
    }
    
    func fetchTopics() -> AnyPublisher<[String], AFError> {
        let endpoint = ArticlesEndpoint.topics

        return AF.request(
            Constants.API.baseURL + endpoint.path,
            method: endpoint.method,
            parameters: endpoint.parameters,
            headers: endpoint.headers
        )
        .validate()
        .publishDecodable(type: [String].self)
        .value()
        .eraseToAnyPublisher()
    }
    
    func fetchArticle(id: String) -> AnyPublisher<[Article], AFError> {
        let endpoint = ArticlesEndpoint.article(id: id)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return AF.request(
            Constants.API.baseURL + endpoint.path,
            method: endpoint.method,
            parameters: endpoint.parameters,
            headers: endpoint.headers
        )
        .validate()
        .publishDecodable(type: [Article].self, decoder: decoder)
        .value()
        .eraseToAnyPublisher()
    }
}


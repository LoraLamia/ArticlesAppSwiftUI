//
//  ArticleRemoteDataSource.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Foundation
import Alamofire
import Combine

final class ArticleRemoteDataSource {
    private let headers: HTTPHeaders = [
        "Authorization" : Constants.API.token
    ]
    
    func fetchArticles(page: Int) -> AnyPublisher<[Article], AFError> {
        let parameters: [String: String] = [
            "page": "\(page)",
            "pageSize": "20",
            "sort": "-1"
        ]
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return AF.request(
            Constants.API.baseURL + Constants.API.articlesEndpoint,
            method: .get,
            parameters: parameters,
            headers: headers
        )
        .validate()
        .publishDecodable(type: ArticlesResponse.self, decoder: decoder)
        .value()
        .map { $0.articles.data }
        .eraseToAnyPublisher()
    }
    
    func fetchTopics() -> AnyPublisher<[String], AFError> {
        return AF.request(
            Constants.API.baseURL + Constants.API.topicsEndpoint,
            method: .get,
            headers: headers
        )
        .validate()
        .publishDecodable(type: [String].self)
        .value()
        .eraseToAnyPublisher()
    }
}


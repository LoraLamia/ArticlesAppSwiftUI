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
    private let onUnauthorized: () -> Void
    private var headers: HTTPHeaders {
        return [
            "Authorization": "Bearer \(KeychainManager.getToken() ?? "")"
        ]
    }
    
    init(onUnauthorized: @escaping () -> Void) {
        self.onUnauthorized = onUnauthorized
    }
    
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
        .handleEvents(receiveCompletion: { [weak self] completion in
            if case .failure(let error) = completion,
               error.responseCode == 401 {
                self?.onUnauthorized()
            }
        })
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


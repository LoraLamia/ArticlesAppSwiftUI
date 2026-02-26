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
    private var headers: HTTPHeaders {
        return [
            "Authorization": "Bearer \(KeychainManager.getToken() ?? "")"
        ]
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
        .tryMap { response in
            
            let statusCode = response.response?.statusCode ?? -1
            print("STATUS CODE:", statusCode)
            
            if let error = response.error {
                print("AF ERROR:", error)
                throw error
            }
            
            guard let value = response.value else {
                throw AFError.responseValidationFailed(reason: .dataFileNil)
            }
            
            return value.articles.data
        }
        .mapError { error in
            error as? AFError ?? AFError.createURLRequestFailed(error: error)
        }
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


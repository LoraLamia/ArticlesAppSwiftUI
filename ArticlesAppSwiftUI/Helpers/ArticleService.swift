//
//  ArticleService.swift
//  ArticlesApp
//
//  Created by Lora Zubic on 08.08.2025..
//

import Foundation
import Alamofire

class ArticleService {
    // Token hardcoded in code, big no!
    private let headers: HTTPHeaders = [
        "Authorization" : Constants.API.token
    ]
    
    func fetchArticles(page: Int, completion: @escaping (Result<[ArticleAPI], AFError>) -> Void) {
        let parameters: [String: String] = [
            "page": "\(page)",
            "pageSize": "20",
            "sort": "-1"
        ]

        // ok, but still better to extract base url into Constants, APIConfig or similar structure
        AF.request(
            Constants.API.baseURL + Constants.API.articlesEndpoint,
            method: .get,
            parameters: parameters,
            headers: headers
        )
        .validate()
        .responseDecodable(of: ArticlesResponse.self) { response in
            switch response.result {
            case .success(let articleResponse):
                let articles = articleResponse.articles.data
                completion(.success(articles))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    func fetchTopics(completion: @escaping (Result<[String], AFError>) -> Void) {
        // see, here you'd have to repeat yourself and change the base url twice if it changed in the future
        AF.request(Constants.API.baseURL + Constants.API.topicsEndpoint, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: [String].self) { response in // what if response  structure changes, will this return empty array, nil or throw and error?
                completion(response.result)
            }
    }
}

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
        "Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5OWM1MjRjNzEzMjM1MzFhNDM5YzcyYSIsInVzZXJuYW1lIjoiZmlmaSIsInJvbGUiOiJCYXNpYyIsImlhdCI6MTc3MTkzNjY0MiwiZXhwIjoxNzcxOTQ3NDQyfQ.MWdfu1mBKtYijS5bOx7QTOpmUcHy18GtqsvFkWQTf6M"
    ]
    
    func fetchArticles(page: Int, completion: @escaping (Result<[Article], AFError>) -> Void) {
        let parameters: [String: String] = [
            "page": "\(page)",
            "pageSize": "20",
            "sort": "-1"
        ]

        // ok, but still better to extract base url into Constants, APIConfig or similar structure
        AF.request(
            "http://192.168.68.86:3000/api/articles",
            method: .get,
            parameters: parameters,
            headers: headers
        )
        .validate()
        .responseDecodable(of: ArticlesResponse.self) { response in
            print("STATUS CODE:", response.response?.statusCode ?? 0)
            if let data = response.data,
               let jsonString = String(data: data, encoding: .utf8) {
                print("JSON:", jsonString)
            }
            print("ERROR:", response.error as Any)
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
        AF.request("http://192.168.68.86:3000/api/articles/topics", method: .get, headers: headers)
            .validate()
            .responseDecodable(of: [String].self) { response in // what if response  structure changes, will this return empty array, nil or throw and error?
                completion(response.result)
            }
    }
}

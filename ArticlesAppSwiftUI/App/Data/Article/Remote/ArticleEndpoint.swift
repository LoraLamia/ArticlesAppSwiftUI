//
//  ArticleEndpoint.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 27.02.2026..
//

import Foundation

enum ArticlesEndpoint: Endpoint {
    case articles(page: Int)
    case topics
    case article(id: String)
    
    var path: String {
        switch self {
        case .articles:
            return Constants.API.articlesEndpoint
        case .topics:
            return Constants.API.topicsEndpoint
        case .article(let id):
            return Constants.API.articleByIdEndpoint + id
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .articles(let page):
            return [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "pageSize", value: "20"),
                URLQueryItem(name: "sort", value: "-1")
            ]
        case .topics, .article:
            return nil
        }
    }
    
    var method: String {
        switch self {
        case .articles, .topics, .article:
            return "GET"
        }
    }
    
    var requiresAuth: Bool {
        switch self {
            case .articles, .topics, .article:
                return true
        }
    }
    
    var body: [String: Any] {
        switch self {
        case .articles, .topics, .article:
            return [:]
        }
    }
    
    func setUpURLRequest() throws -> URLRequest {
        var components = URLComponents(
            string: Constants.API.baseURL + path
        )
        
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
                
        if requiresAuth {
            guard let token = KeychainManager.getToken() else {
                throw URLError(.userAuthenticationRequired)
            }
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}

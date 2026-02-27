//
//  ArticleEndpoint.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 27.02.2026..
//

import Alamofire

enum ArticlesEndpoint {
    
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
    
    var parameters: Parameters? {
        switch self {
        case .articles(let page):
            return [
                "page": "\(page)",
                "pageSize": "20",
                "sort": "-1"
            ]
        case .topics, .article:
            return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .articles, .topics, .article:
            guard let token = KeychainManager.getToken() else { return nil }
            return ["Authorization": "Bearer \(token)"]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .articles, .topics, .article:
            return .get
        }
    }
}

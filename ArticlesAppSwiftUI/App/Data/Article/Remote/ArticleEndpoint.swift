//
//  ArticleEndpoint.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 27.02.2026..
//

import Alamofire
import Foundation

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
        "GET"
    }
    
    var requiresAuth: Bool {
        true
    }
}

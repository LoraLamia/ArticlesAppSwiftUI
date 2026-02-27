//
//  ArticleDataSourceContract.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 27.02.2026..
//

import Combine
import Alamofire

protocol ArticleDataSourceContract {
    func fetchArticles(page: Int) -> AnyPublisher<[Article], AFError>
    func fetchTopics() -> AnyPublisher<[String], AFError>
    func fetchArticle(id: String) -> AnyPublisher<[Article], AFError>
}


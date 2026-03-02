//
//  ArticlesDataSourceContract.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 27.02.2026..
//

import Combine
import Alamofire

protocol ArticlesDataSourceContract {
    func fetchArticles(page: Int) -> AnyPublisher<[Article], Error>
    func fetchTopics() -> AnyPublisher<[String], Error>
    func fetchArticle(id: String) -> AnyPublisher<[Article], Error>
}


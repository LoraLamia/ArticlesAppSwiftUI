//
//  Article.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import Foundation

nonisolated
struct Article: Codable, Identifiable {
    let id: String
    let title: String
    let summary: String
    let author: String
    let topic: String
    let tags: [String]
    let publishedAt: Date
}

nonisolated
struct ArticlesResponse: Codable {
    let articles: ArticlesContainer
}

struct ArticlesContainer: Codable {
    let metadata: Metadata
    let data: [Article]
}

struct Metadata: Codable {
    let totalCount: Int
    let page: Int
    let pageSize: Int
}


//
//  ArticleCellView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

struct ArticleCellView: View {
    let article: Article
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 6) {
                HStack {
                    Text(article.title)
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                }
                HStack {
                    Text(article.author)
                        .font(.system(size: 18))
                        .foregroundStyle(
                            Color(
                                red: 60/255,
                                green: 60/255,
                                blue: 67/255,
                                opacity: 0.6
                            )
                        )
                    Spacer()
                    Text(article.publishedAt, format: .dateTime
                        .month(.abbreviated)
                        .day()
                        .year()
                        .hour()
                        .minute()
                    )
                    .font(.system(size: 16))
                    .foregroundStyle(
                        Color(
                            red: 60/255,
                            green: 60/255,
                            blue: 67/255,
                            opacity: 0.6
                        )
                    )
                }
                HStack {
                    Text(article.summary)
                        .font(.system(size: 14))
                        .foregroundStyle(
                            Color(
                                red: 85/255,
                                green: 85/255,
                                blue: 85/255
                            )
                        )
                    Spacer()
                }
                HStack {
                    Text("Topic: \(article.topic) Tags: \(article.tags.joined(separator: ", "))")
                        .font(.system(size: 16))
                        .foregroundStyle(.blue)
                    Spacer()
                }
            }
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 25)
                .foregroundStyle(.blue)
        }
        .padding()
        .background(
            Color(
                red: 230/255,
                green: 229/255,
                blue: 227/255
            )
        )
        .shadow(radius: 6)
    }
}

//
//  ArticleCellView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

struct ArticleCellView: View {
    let article: Article
    let isFavorite: Bool
    let onFavoriteTap: () -> Void
    
    var body: some View {
        HStack(spacing: Constants.Spacing.normal) {
            VStack(spacing: Constants.Spacing.extraSmall) {
                HStack {
                    Text(article.title)
                        .font(.system(size: Constants.Fonts.large, weight: .bold))
                    Spacer()
                }
                HStack {
                    Text(article.author)
                        .font(.system(size: Constants.Fonts.normal))
                        .foregroundStyle(Constants.Colors.authorAndDateTextColor)

                    Spacer()
                    Text(article.publishedAt, format: .dateTime
                        .month(.abbreviated)
                        .day()
                        .year()
                        .hour()
                        .minute()
                    )
                    .font(.system(size: Constants.Fonts.small))
                    .foregroundStyle(Constants.Colors.authorAndDateTextColor)
                }
                HStack {
                    Text(article.summary)
                        .font(.system(size: Constants.Fonts.extraSmall))
                        .foregroundStyle(Constants.Colors.summaryTextColor)
                    Spacer()
                }
                HStack {
                    Text("Topic: \(article.topic) Tags: \(article.tags.joined(separator: ", "))")
                        .font(.system(size: Constants.Fonts.small))
                        .foregroundStyle(Constants.Colors.primaryColor)
                    Spacer()
                }
            }
            Button {
                onFavoriteTap()
            } label: {
                Image(systemName: isFavorite ? Constants.Icons.favoriteIconName : Constants.Icons.unfavoriteIconName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: Constants.Height.normal)
                    .foregroundStyle(Constants.Colors.primaryColor)
            }
        }
        .padding()
        .background(Constants.Colors.cellBackgroundColor)
        .shadow(radius: 6)
    }
}

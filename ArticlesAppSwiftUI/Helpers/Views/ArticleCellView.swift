//
//  ArticleCellView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

struct ArticleCellView: View {
    let article: Article
    let isFavorite: Bool?
    let onFavoriteTap: (() -> Void)?
    
    var body: some View {
        HStack(spacing: Constants.Spacing.normal) {
            contentSection
            favoriteButton
        }
        .padding()
        .background(Constants.Colors.cellBackgroundColor)
        .shadow(radius: 6)
    }
    
    private var contentSection: some View {
        VStack(spacing: Constants.Spacing.extraSmall) {
            titleSection
            metaSection
            summarySection
            topicAndTagsSection
        }
    }
    
    private var titleSection: some View {
        Text(article.title)
            .font(.system(size: Constants.Fonts.large, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var metaSection: some View {
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
    }
    
    private var summarySection: some View {
        Text(article.summary)
            .font(.system(size: Constants.Fonts.extraSmall))
            .foregroundStyle(Constants.Colors.summaryTextColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var topicAndTagsSection: some View {
        Text("Topic: \(article.topic) Tags: \(article.tags.joined(separator: ", "))")
            .font(.system(size: Constants.Fonts.small))
            .foregroundStyle(Constants.Colors.primaryColor)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder private var favoriteButton: some View {
        if let isFavorite, let onFavoriteTap {
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
    }
}

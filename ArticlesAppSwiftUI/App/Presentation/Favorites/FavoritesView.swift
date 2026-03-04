//
//  FavoritesView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

struct FavoritesView: View {
    @Environment(AnalyticsService.self) private var analyticsService
    @State var viewModel: FavoritesViewModel

    var body: some View {
        favoritesList
    }
    
    private var favoritesList: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.articles) { article in
                    ArticleCellView(
                        article: article,
                        isFavorite: true,
                        onFavoriteTap: {
                            analyticsService.log(ArticlesEvent.favoriteToggled(isNowFavorite: false))
                            viewModel.toggleFavorite(article: article)
                        }
                    )
                }
            }
        }
    }
}




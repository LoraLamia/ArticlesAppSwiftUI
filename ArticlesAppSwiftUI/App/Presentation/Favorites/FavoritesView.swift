//
//  FavoritesView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject var viewModel: FavoritesViewModel

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.articles) { article in
                        ArticleCellView(
                            article: article,
                            isFavorite: true,
                            onFavoriteTap: {
                                viewModel.toggleFavorite(article: article)
                            }
                        )
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadArticles()
        }
    }
}




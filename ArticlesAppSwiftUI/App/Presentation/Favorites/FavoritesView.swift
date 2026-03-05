//
//  FavoritesView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

struct FavoritesView: View {
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
                        onFavoriteTap: { viewModel.onFavoriteTap(article: article) }
                    )
                }
            }
        }
    }
}




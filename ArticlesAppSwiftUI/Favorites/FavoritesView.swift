//
//  FavoritesView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

struct FavoritesView: View {
    
    @StateObject private var viewModel = FavoritesViewModel()

    var body: some View {
        VStack {
            
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.articles) { article in
                        ArticleCellView(article: article)
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadArticles()
        }
    }
}




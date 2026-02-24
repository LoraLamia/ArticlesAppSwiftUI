//
//  AllArticlesView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

struct AllArticlesView: View {
    
    @ObservedObject private var viewModel = ArticlesViewModel()

    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchText)
                .padding()
            
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.filteredArticles) { article in
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


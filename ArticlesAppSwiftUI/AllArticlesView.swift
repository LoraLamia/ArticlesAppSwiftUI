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
            HStack {
                SearchBar(text: $viewModel.searchText)
                Button {
                    viewModel.isAscending.toggle()
                } label: {
                    Image(systemName: viewModel.isAscending ? "arrow.up" : "arrow.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15)
                        .foregroundStyle(.blue)
                }
            }
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


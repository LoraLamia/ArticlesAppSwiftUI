//
//  AllArticlesView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

struct AllArticlesView: View {
    @State var viewModel: AllArticlesViewModel

    var body: some View {
        VStack {
            searchBar
            topicsList
            articlesList
        }
        .overlay {
            if viewModel.isLoading {
                ZStack {
                    Color.black.opacity(0.7)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .scaleEffect(1.5)
                        .progressViewStyle(.circular)
                }
            }
        }
    }
    
    private var articlesList: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.filteredArticles) { article in
                    ArticleCellView(
                        article: article,
                        isFavorite: viewModel.isFavorite(article),
                        onFavoriteTap: {
                            viewModel.toggleFavorite(article: article)
                        }
                    )
                }
            }
        }
    }
    
    private var topicsList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Constants.Spacing.small) {
                
                TopicCellView(
                    callback: { viewModel.selectedTopic = nil },
                    topic: Constants.Strings.allArticles,
                    isSelected: viewModel.selectedTopic == nil
                )
                
                ForEach(viewModel.topics, id: \.self) { topic in
                    TopicCellView(
                        callback: { viewModel.selectedTopic = topic },
                        topic: topic,
                        isSelected: viewModel.selectedTopic == topic
                    )
                }
            }
            .padding(.horizontal, Constants.Padding.small)
        }
        .padding(.bottom, Constants.Padding.small)
    }
    
    private var searchBar: some View {
        HStack {
            SearchBar(text: $viewModel.searchText)
            Button {
                viewModel.isAscending.toggle()
            } label: {
                Image(systemName: viewModel.isAscending ? Constants.Icons.arrowUpName : Constants.Icons.arrowDownName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: Constants.Height.extraSmall)
                    .foregroundStyle(.blue)
            }
        }
        .padding(Constants.Padding.small)
    }
}


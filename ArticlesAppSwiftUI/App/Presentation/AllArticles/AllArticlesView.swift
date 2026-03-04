//
//  AllArticlesView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

struct AllArticlesView: View {
    @Environment(AnalyticsService.self) private var analyticsService
    @Environment(FeatureManager.self) private var featureManager
    @State var viewModel: AllArticlesViewModel

    var body: some View {
        if viewModel.isLoading {
            loadingView
        } else {
            contentView
        }
    }
    
    private var contentView: some View {
        VStack {
            searchBar
            topicsList
            articlesList
        }
    }
    
    private var loadingView: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()

            ProgressView()
                .scaleEffect(1.5)
                .progressViewStyle(.circular)
        }
    }
    
    private var articlesList: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.filteredArticles) { article in
                    let isFavorite = viewModel.isFavorite(article)
                    ArticleCellView(
                        article: article,
                        isFavorite: featureManager.isFavoritesEnabled ? isFavorite : nil,
                        onFavoriteTap: featureManager.isFavoritesEnabled ? {
                            let newValue = !isFavorite
                            analyticsService.log(ArticlesEvent.favoriteToggled(isNowFavorite: newValue))
                            viewModel.toggleFavorite(article: article)
                        } : nil
                    )
                }
            }
        }
    }
    
    private var topicsList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Constants.Spacing.small) {
                
                TopicCellView(
                    action: { viewModel.selectedTopic = nil },
                    topic: Constants.Strings.allArticles,
                    isSelected: viewModel.selectedTopic == nil
                )
                
                ForEach(viewModel.topics, id: \.self) { topic in
                    TopicCellView(
                        action: { viewModel.selectedTopic = topic },
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
                let newValue = !viewModel.isAscending
                analyticsService.log(ArticlesEvent.sortChanged(isAscending: newValue))
                viewModel.isAscending = newValue
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


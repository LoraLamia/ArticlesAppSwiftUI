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
                
                Button {
                    viewModel.selectedTopic = nil
                } label: {
                    Text(Constants.Strings.allArticles)
                        .padding(.horizontal, Constants.Padding.small)
                        .padding(.vertical, Constants.Padding.extraSmall)
                        .background(viewModel.selectedTopic == nil ? Constants.Colors.topicCellSelectedColor : Constants.Colors.topicCellUnselectedColor)
                        .foregroundColor(viewModel.selectedTopic == nil ? Constants.Colors.topicCellTextSelectedColor : Constants.Colors.topicCellTextUnselectedColor)
                        .cornerRadius(Constants.CornerRadius.normal)
                }
                
                ForEach(viewModel.topics, id: \.self) { topic in
                    Button {
                        viewModel.selectedTopic = topic
                    } label: {
                        Text(topic)
                            .padding(.horizontal, Constants.Padding.small)
                            .padding(.vertical, Constants.Padding.extraSmall)
                            .background(viewModel.selectedTopic == topic ? Constants.Colors.topicCellSelectedColor : Constants.Colors.topicCellUnselectedColor)
                            .foregroundColor(viewModel.selectedTopic == topic ? Constants.Colors.topicCellTextSelectedColor : Constants.Colors.topicCellTextUnselectedColor)
                            .cornerRadius(Constants.CornerRadius.normal)
                    }
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


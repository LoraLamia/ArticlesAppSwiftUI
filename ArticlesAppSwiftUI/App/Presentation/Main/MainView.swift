//
//  MainView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

struct MainView: View {
    @Environment(DependencyContainer.self) private var container
    @Environment(SessionManager.self) private var session

    var body: some View {
        TabView {
            AllArticlesView(
                viewModel: AllArticlesViewModel(
                    articleUseCase: container.articleUseCase,
                    session: session
                )
            )
                .tabItem {
                    Label(Constants.Strings.articles, systemImage: Constants.Icons.listName)
                }

            FavoritesView(
                viewModel: FavoritesViewModel(
                    articleUseCase:
                        container.articleUseCase
                )
            )
                .tabItem {
                    Label(Constants.Strings.favorites, systemImage: Constants.Icons.favoriteIconName)
                }
        }
    }
}

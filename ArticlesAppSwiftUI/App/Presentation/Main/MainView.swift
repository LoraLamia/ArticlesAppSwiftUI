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
    @Environment(FeatureManager.self) private var featureManager

    var body: some View {
        if featureManager.isFavoritesEnabled {
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
        } else {
            AllArticlesView(
                viewModel: AllArticlesViewModel(
                    articleUseCase: container.articleUseCase,
                    session: session
                )
            )
        }
    }
}

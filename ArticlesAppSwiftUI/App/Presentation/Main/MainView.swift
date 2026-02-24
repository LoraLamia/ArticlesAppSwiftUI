//
//  MainView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            AllArticlesView()
                .tabItem {
                    Label(Constants.Strings.articles, systemImage: Constants.Icons.listName)
                }

            FavoritesView()
                .tabItem {
                    Label(Constants.Strings.favorites, systemImage: Constants.Icons.favoriteIconName)
                }
        }
    }
}

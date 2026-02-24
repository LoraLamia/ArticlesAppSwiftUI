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
                    Label("Articles", systemImage: "text.document")
                }

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }
    }
}

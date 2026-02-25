//
//  RootView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import SwiftUI

struct RootView: View {
    
    @Environment(SessionManager.self) private var session
    let container: DependencyContainer
    
    var body: some View {
        Group {
            if session.isLoggedIn {
                MainView(container: container)
            } else {
                WelcomeScreenView(container: container)
            }
        }
    }
}

